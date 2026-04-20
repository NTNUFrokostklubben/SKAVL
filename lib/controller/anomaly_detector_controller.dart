import 'package:skavl/proto/anomaly.pbgrpc.dart';

/// Anomaly Detector Controller handles the communication with the anomaly detection service.
///
/// This class provides methods for common operations such as getting project info, running analysis and manipulating data.
class AnomalyDetectorController {
  AnomalyDetectorController({required this.anomalyDetectorClient});

  final AnomalyDetectorServiceClient anomalyDetectorClient;

  /// Gets the project information from the anomaly detection service.
  ///
  /// Currently does not use information for anything, but response has been tested with print so it is ready for implementation.
  Future<DescribeAnomalyProjectResponse> getProjectInfo({
    required String projectName,
    required String imagePath,
    required String sosiPath,
  }) async => await anomalyDetectorClient.describeAnomalyProject(
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

  Future<GetProgressResponse> getProgress({
    required String projectName
  }) async => await anomalyDetectorClient.getProgress(
      GetProgressRequest(
        projectName: projectName
      ),
    );
}
