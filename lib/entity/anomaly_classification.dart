import 'package:skavl/widgets/dialogs/confirm_anomaly_popup.dart';

import 'anomaly_def.dart';

/// Class for classifying anomalies
///
/// Used primarily with [ConfirmAnomalyDialog]
class AnomalyClassification {
  final AnomalyDef anomalyDef;
  final String? userClassification;

  AnomalyClassification({
    required this.anomalyDef,
    required this.userClassification,
  });
}
