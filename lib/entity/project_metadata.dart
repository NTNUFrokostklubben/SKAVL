import 'package:skavl/entity/anomaly_def.dart';
import 'package:skavl/entity/anomaly_set.dart';

/// Represents the metadata per project loaded. This class will probably be
/// populated from a datasource at some point, however for now we can use this
/// internally for single project applications.
///
/// allSets will hold all image metadata from the analysis,
/// while anomaliesInRange will hold only the metadata for the images that are within the sensitivity threshold.
///
/// currentPage is the current anomaly being analyzed within the range 1..Size(anomaliesInRange)
class ProjectMetadata {
  final String projectName;
  final String sosiFilePath;
  final String imageFolderPath;
  final String? sosiWaterMaskPath;
  final List<AnomalySet> allSets;
  final double sensitivity;
  final int currentPage;

  ProjectMetadata({
    required this.projectName,
    required this.sosiFilePath,
    required this.imageFolderPath,
    this.sosiWaterMaskPath,
    this.allSets = const [],
    this.sensitivity = 0.5,
    this.currentPage = 0,
  });

  /// For project management
  Map<String, dynamic> toJson() => {
    'version': 1,
    'projectName': projectName,
    'paths': {
      'sosiFilePath': sosiFilePath,
      'imageFolderPath': imageFolderPath,
      'sosiWaterMaskPath': sosiWaterMaskPath,
    },
    'sensitivity': sensitivity,
    'currentPage': currentPage,
    'anomalySets': allSets.map((s) => s.toJson()).toList(),
  };

  /// For project management
  factory ProjectMetadata.fromJson(Map<String, dynamic> json) {
    final paths = json['paths'] as Map<String, dynamic>;
    return ProjectMetadata(
      projectName: json['projectName'] as String,
      sosiFilePath: paths['sosiFilePath'] as String,
      imageFolderPath: paths['imageFolderPath'] as String,
      sosiWaterMaskPath: paths['sosiWaterMaskPath'] as String?,
      sensitivity: (json['sensitivity'] as num).toDouble(),
      currentPage: json['currentPage'] as int,
      allSets: (json['anomalySets'] as List)
          .map((e) => AnomalySet.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  /// For mutable project files
  ProjectMetadata copyWith({
    String? projectName,
    String? sosiFilePath,
    String? imageFolderPath,
    String? sosiWaterMaskPath,
    List<AnomalySet>? allSets,
    double? sensitivity,
    int? currentPage,
  }) => ProjectMetadata(
    projectName: projectName ?? this.projectName,
    sosiFilePath: sosiFilePath ?? this.sosiFilePath,
    imageFolderPath: imageFolderPath ?? this.imageFolderPath,
    sosiWaterMaskPath: sosiWaterMaskPath ?? this.sosiWaterMaskPath,
    allSets: allSets ?? this.allSets,
    sensitivity: sensitivity ?? this.sensitivity,
    currentPage: currentPage ?? this.currentPage,
  );

  /// Returns list of anomalies based on confidence and sensitivity
  List<AnomalySet> get anomaliesInRange =>
      allSets.where((s) => s.anomalyConf >= sensitivity).toList();

  /// Returns list of anomalies that are not yet classified
  List<AnomalySet> get unclassifiedAnomaliesInRange => anomaliesInRange
      .where((s) => s.anomalyDef == AnomalyDef.undefined)
      .toList();

  /// Returns list of anomalies that are classified
  List<AnomalySet> get classifiedAnomaliesInRange => anomaliesInRange
      .where((s) => s.anomalyDef != AnomalyDef.undefined)
      .toList();
}
