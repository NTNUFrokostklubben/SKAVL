import 'package:skavl/entity/anomaly_def.dart';

enum AnomalyType { undefined, colorAverage, waterMask, artifact }

/// Represents each "set" of data included in a page of the main application.
/// Each detected anomaly will be a set and the data on this set will be used
/// to display the image, surrounding images and the anomaly definition.
class AnomalySet {
  final String imageName;
  final AnomalyDef anomalyDef;
  final String? userClassification;
  final double anomalyConf;
  final int lineNumber;
  final int imageNumber;
  final AnomalyType anomalyType;

  AnomalySet({
    required this.imageName,
    this.anomalyDef = AnomalyDef.undefined,
    this.userClassification,
    required this.anomalyConf,
    required this.lineNumber,
    required this.imageNumber,
    this.anomalyType = AnomalyType.undefined,
  });

  /// For project management
  Map<String, dynamic> toJson() => {
    'imageName': imageName,
    'anomalyConf': anomalyConf,
    'lineNumber': lineNumber,
    'imageNumber': imageNumber,
    'anomalyDef': anomalyDef.name,
    'anomalyType': anomalyType.name,
    'userClassification': userClassification,
  };

  /// For project management
  factory AnomalySet.fromJson(Map<String, dynamic> json) => AnomalySet(
    imageName: json['imageName'] as String,
    anomalyConf: (json['anomalyConf'] as num).toDouble(),
    lineNumber: json['lineNumber'] as int,
    imageNumber: json['imageNumber'] as int,
    anomalyDef: AnomalyDef.values.byName(json['anomalyDef'] as String),
    anomalyType: AnomalyType.values.byName(json['anomalyType'] as String? ?? 'undefined'),
    userClassification: json['userClassification'] as String?,
  );

  /// For updating the anomaly classification
  AnomalySet copyWith({
    AnomalyDef? anomalyDef,
    String? userClassification,
    bool clearUserClassification = false,
  }) => AnomalySet(
    imageName: imageName,
      anomalyDef: anomalyDef ?? this.anomalyDef,
      userClassification: clearUserClassification
          ? null
          : userClassification ?? this.userClassification,
      anomalyConf: anomalyConf,
      lineNumber: lineNumber,
      imageNumber: imageNumber,
      anomalyType: anomalyType,
  );
}


