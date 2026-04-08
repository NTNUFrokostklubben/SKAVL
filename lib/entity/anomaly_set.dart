import 'package:skavl/entity/anomaly_def.dart';

/// Represents each "set" of data included in a page of the main application.
/// Each detected anomaly will be a set and the data on this set will be used
/// to display the image, surrounding images and the anomaly definition.
class AnomalySet {
  final String imageName;
  final AnomalyDef anomalyDef;
  final double anomalyConf;
  final int lineNumber;
  final int imageNumber;

  AnomalySet({
    required this.imageName,
    required this.anomalyDef,
    required this.anomalyConf,
    required this.lineNumber,
    required this.imageNumber,
  });

  /// For project management
  Map<String, dynamic> toJson() => {
    'imageName': imageName,
    'anomalyConf': anomalyConf,
    'lineNumber': lineNumber,
    'imageNumber': imageNumber,
    'anomalyDef': anomalyDef.name,
  };

  /// For project management
  factory AnomalySet.fromJson(Map<String, dynamic> json) => AnomalySet(
    imageName: json['imageName'] as String,
    anomalyConf: (json['anomalyConf'] as num).toDouble(),
    lineNumber: json['lineNumber'] as int,
    imageNumber: json['imageNumber'] as int,
    anomalyDef: AnomalyDef.values.byName(json['anomalyDef'] as String),
  );
}
