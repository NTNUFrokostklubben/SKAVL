import 'package:flutter/material.dart';
import 'package:skavl/widgets/analysis/free_view.dart';

/// Overlay widget for highlighting a region on a screen.
///
/// Primarily used in [FreeView] to display images selected in relation to opacity control.
class ImageSelectionOverlay extends StatelessWidget {
  final Rect screenRect;
  final String label;

  const ImageSelectionOverlay({
    super.key,
    required this.screenRect,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned.fromRect(
      rect: screenRect,
      child: IgnorePointer(
        child: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.secondary.withValues(alpha: 0.40),
            border: Border.all(
              color: Theme.of(context).colorScheme.secondary,
              width: 2,
            ),
          ),
          alignment: Alignment.center,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface.withValues(alpha: 0.85),
              borderRadius: BorderRadius.circular(5),
            ),
            child: Text(
              label,
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
        ),
      ),
    );
  }
}