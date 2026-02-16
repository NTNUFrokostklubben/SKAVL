
/// Represents each "set" of data included in a page of the main application.
/// Each detected anomaly will be a set and the data on this set will be used
/// to display the image, surrounding images and the anomaly definition.
class AnomalySet {
  final String imageName;
  final Enum anomalyDef;
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
}
