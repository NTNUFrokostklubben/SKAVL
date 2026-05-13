import 'package:flutter/material.dart';

/// Generic vertical slider widget.
///
/// Exposes a callback for when slider value changes.
class VerticalSlider extends StatelessWidget {
  final double value;
  final ValueChanged<double> onChanged;

  const VerticalSlider({
    super.key,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        border: Border.all(color: Theme.of(context).colorScheme.secondary, width: 1),
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: 200,
            child: RotatedBox(
              quarterTurns: 3,
              child: Slider(
                inactiveColor: Theme.of(context).colorScheme.surfaceContainerHighest,
                value: value,
                onChanged: onChanged,
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text('${(value * 100).round()}%'),
        ],
      ),
    );
  }

}
