
import 'package:skavl/proto/anomaly.pbgrpc.dart';

class AnomalyDetectorController {
  AnomalyDetectorController({required this.anomalyDetectorClient});

  final AnomalyDetectorServiceClient anomalyDetectorClient;

  Future<void> getProjectInfo({
    required String projectName,
    required String imagePath,
    required String sosiPath,
  }) async {
    final response = await anomalyDetectorClient.describeAnomalyProject(
      DescribeAnomalyProjectRequest(
        projectMetadata: ProjectMetadata(
          sosiFilePath: sosiPath,
          imageFolderPath: imagePath,
          projectName: projectName,
        ),
      ),
    );
    print(response);
  }

  Future<void> runAnalysis({
    required String imagePath,
    required String sosiPath,
    required String projectName,
    String waterSosiPath = "",
  }) async {
    final metadata = ProjectMetadata()
      ..projectName = projectName
      ..imageFolderPath = imagePath
      ..sosiFilePath = sosiPath;

    if (waterSosiPath.isNotEmpty) {
      metadata.sosiWaterMaskPath = waterSosiPath;
    }

    final response = await anomalyDetectorClient.detectAnomalySet(
      DetectAnomalySetRequest(
        projectMetadata: metadata,
        startMode: StartMode.START_RESTART,
      ),
    );
    print(response);
  }
}