import 'dart:ffi';

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
  final List<AnomalySet> allSets;
  final List<AnomalySet> anomaliesInRange;
  final double sensitivity;
  final int currentPage;

  ProjectMetadata({
    required this.projectName,
    required this.allSets,
    required this.anomaliesInRange,
    required this.sensitivity,
    required this.currentPage,
  });
}
