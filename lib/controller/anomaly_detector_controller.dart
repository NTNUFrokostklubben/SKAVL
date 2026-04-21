import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:skavl/proto/anomaly.pbgrpc.dart';

import '../entity/analysis_progress.dart';

/// Anomaly Detector Controller handles the communication with the anomaly detection service.
///
/// This class provides methods for common operations such as getting project info, running analysis and manipulating data.
class AnomalyDetectorController {
  AnomalyDetectorController({required this.anomalyDetectorClient});

  final AnomalyDetectorServiceClient anomalyDetectorClient;

  // Used for polling for progress.
  Timer? _progressTimer;

  /// Gets the project information from the anomaly detection service.
  ///
  /// Currently does not use information for anything, but response has been tested with print so it is ready for implementation.
  Future<DescribeAnomalyProjectResponse> getProjectInfo({
    required String projectName,
    required String imagePath,
    required String sosiPath,
  }) async =>
      await anomalyDetectorClient.describeAnomalyProject(
        DescribeAnomalyProjectRequest(
          projectMetadata: ProjectMetadata(
            sosiFilePath: sosiPath,
            imageFolderPath: imagePath,
            projectName: projectName,
          ),
        ),
      );

  /// Sends a start procedure to the anomaly service with supplied data.
  ///
  /// Currently does not use information for anything, but response has been tested with print so it is ready for implementation.
  Future<DetectAnomalySetResponse> runAnalysis({
    required String imagePath,
    required String sosiPath,
    required String projectName,
    String? waterSosiPath = "",
  }) async {
    final metadata = ProjectMetadata()
      ..projectName = projectName
      ..imageFolderPath = imagePath
      ..sosiFilePath = sosiPath;

    if (waterSosiPath?.isNotEmpty ?? false) {
      metadata.sosiWaterMaskPath = waterSosiPath!;
    }

    return await anomalyDetectorClient.detectAnomalySet(
      DetectAnomalySetRequest(
        projectMetadata: metadata,
        startMode: StartMode.START_RESTART,
      ),
    );
  }

  /// Gets progress of analysis
  Future<GetProgressResponse> getProgress({
    required String projectName
  }) async =>
      await anomalyDetectorClient.getProgress(
        GetProgressRequest(
            projectName: projectName
        ),
      );

  void startPolling({
    required String projectName,
    required ValueNotifier<AnalysisProgress> progress
  }) async {
    // initial request to populate progress before poll starts.
    final response = await anomalyDetectorClient.getProgress(
      GetProgressRequest(projectName: projectName),
    );
    progress.value = AnalysisProgress(response.lastProcessedImage, response.totalImages);

    _progressTimer = Timer.periodic(const Duration(seconds: 10), (_) async {
      final response = await anomalyDetectorClient.getProgress(
        GetProgressRequest(projectName: projectName),
      );
      progress.value = AnalysisProgress(response.lastProcessedImage, response.totalImages);
    });
  }

  void stopPolling() {
    _progressTimer?.cancel();
    _progressTimer = null;
  }
}
