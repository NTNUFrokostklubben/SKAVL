enum ViewMode { horizontal, vertical, overlay, gridsmall, gridbig, free }

/// Extension to determine image counts for viewport bounds
extension ViewModeImageCount on ViewMode {
  /// Get max images to fetch per [ViewMode] for analysis.
  int get imageCount {
    switch (this) {
      case ViewMode.horizontal:
        return 5;
      case ViewMode.vertical:
        return 5;
      case ViewMode.overlay:
        return 2;
      case ViewMode.gridsmall:
        return 4;
      case ViewMode.gridbig:
        return 9;
      case ViewMode.free:
        return 5;
    }
  }
}
