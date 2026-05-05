import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:grpc/grpc.dart';
import 'package:skavl/entity/anomaly_set.dart';
import 'package:skavl/entity/project_metadata.dart';
import 'package:skavl/proto/report.pb.dart';
import 'package:skavl/proto/report.pbgrpc.dart';
import 'package:skavl/services/port_config_service.dart';
import 'package:skavl/util/file_system_util.dart';

import '../proto/anomaly.pb.dart' as pb2;

/// gRPC specific controller/adapter controller for interfacing with report generation module
class ReportGenerationController {
  ReportGenerationController();

  final _reportServiceConfig = PortConfigService().getConfig("skavl_report");
  late final _channel = ClientChannel(
    _reportServiceConfig.ip,
    port: _reportServiceConfig.port,
    options: const ChannelOptions(credentials: ChannelCredentials.insecure()),
  );
  late final _client = ReportServiceClient(_channel);

  /// Generates an unclassified report based on projectName
  Future<void> generateUnclassifiedReport({
    required ProjectMetadata projectMetadata,
    required List<AnomalySet> anomalies,
    required double confidenceThreshold,
    required String locale,
  }) async => await _client
      .generateReportUnclassified(
        ReportGenerationRequest(
          projectMetadata: pb2.ProjectMetadata(
            projectName: projectMetadata.projectName,
            sosiFilePath: projectMetadata.sosiFilePath,
            imageFolderPath: projectMetadata.imageFolderPath,
            sosiWaterMaskPath: projectMetadata.sosiWaterMaskPath,
          ),
          anomalySets: projectMetadata.anomaliesInRange.map(
            (a) => pb2.AnomalySet(
              imageNumber: a.imageNumber,
              lineNumber: a.lineNumber,
              imageName: a.imageName,
              anomalyType: pb2.AnomalyTypes.valueOf(a.anomalyType.index),
              userClassification: a.userClassification,
              geotiffCoordinate: pb2.UtmCoordinate(easting: 0, northing: 0),
              anomalyConfidence: a.anomalyConf,
            ),
          ),
          confidenceThreshold: projectMetadata.sensitivity,
          locale: locale,
          saveLocation: await _pickPath(
            projectMetadata,
            classification: 'unclassified',
          ),
        ),
      )
      .then((r) => FileSystemUtil.openDirectory(r.reportUrl));

  /// Generates an unclassified report based on projectName
  Future<void> generateClassifiedReport({
    required ProjectMetadata projectMetadata,
    required List<AnomalySet> anomalies,
    required double confidenceThreshold,
    required String locale,
  }) async => await _client
      .generateReportClassified(
        ReportGenerationRequest(
          projectMetadata: pb2.ProjectMetadata(
            projectName: projectMetadata.projectName,
            sosiFilePath: projectMetadata.sosiFilePath,
            imageFolderPath: projectMetadata.imageFolderPath,
            sosiWaterMaskPath: projectMetadata.sosiWaterMaskPath,
          ),
          anomalySets: projectMetadata.anomaliesInRange.map(
            (a) => pb2.AnomalySet(
              imageNumber: a.imageNumber,
              lineNumber: a.lineNumber,
              imageName: a.imageName,
              anomalyType: pb2.AnomalyTypes.valueOf(a.anomalyType.index),
              userClassification: a.userClassification,
              geotiffCoordinate: pb2.UtmCoordinate(easting: 0, northing: 0),
              anomalyConfidence: a.anomalyConf,
            ),
          ),
          confidenceThreshold: projectMetadata.sensitivity,
          locale: locale,
          saveLocation: await _pickPath(
            projectMetadata,
            classification: 'classified',
          ),
        ),
      )
      .then((r) => FileSystemUtil.openDirectory(r.reportUrl));

  Future<String> _pickPath(
    ProjectMetadata projectMetadata, {
    required String classification,
  }) async {
    DateTime currentTime = DateTime.timestamp();
    String? result = await FilePicker.saveFile(
      dialogTitle: 'Save report',
      fileName:
          '${projectMetadata.projectName}-report-$classification-${currentTime.year}${currentTime.month}${currentTime.day}${currentTime.hour}${currentTime.minute}.pdf',
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null) {
      return result;
    } else {
      return "";
    }
  }
}
