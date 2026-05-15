import 'package:skavl/entity/anomaly_set.dart';

/// Merges [incoming] anomaly sets into [existing] replacing existing entries that share imageName.
///
/// Used when continuing analysis to not overwrite entire analysis.
List<AnomalySet> mergeAnomalySets(
    List<AnomalySet> existing,
    List<AnomalySet> incoming,
    ) {
  final incomingNames = incoming.map((s) => s.imageName).toSet();
  return [
    ...existing.where((s) => !incomingNames.contains(s.imageName)),
    ...incoming,
  ];
}