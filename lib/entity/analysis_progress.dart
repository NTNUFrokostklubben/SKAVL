
import 'package:flutter/cupertino.dart';

/// Class for representing images processed and total images to process
///
/// Primarily used in [ValueNotifier] to reduce coupling
class AnalysisProgress {
  final int processed;
  final int total;
  final bool isStopping;
  AnalysisProgress(this.processed, this.total, {this.isStopping = false});
}