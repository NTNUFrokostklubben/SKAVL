import 'package:flutter/material.dart';

/// Semantic LargeHeader component to represent headers
///
/// Acts as wrapper for [Text] and applies [labelLarge] from ThemeData
/// Uses Semantic labels for screen readers
class LargeLabel extends StatelessWidget {
  final String text;
  final String? semanticLabel;
  const LargeLabel(this.text, {super.key, this.semanticLabel});

  @override
  Widget build(BuildContext context) {
    return Semantics(
      header: false,
      label: semanticLabel,
      child: Text(text, style: Theme.of(context).textTheme.labelLarge),
    );
  }
}

/// Semantic LargeHeader component to represent headers
/// Acts as wrapper for [Text] and applies [labelMedium] from ThemeData
class MediumLabel extends StatelessWidget {
  final String text;
  final String? semanticLabel;
  const MediumLabel(this.text, {super.key, this.semanticLabel});

  @override
  Widget build(BuildContext context) {
    return Semantics(
      header: false,
      label: semanticLabel,
      child: Text(text, style: Theme.of(context).textTheme.labelMedium),
    );
  }
}

/// Semantic SmallHeader component to represent headers
/// Acts as wrapper for [Text] and applies [labelSmall] from ThemeData
class SmallLabel extends StatelessWidget {
  final String text;
  final String? semanticLabel;
  const SmallLabel(this.text, {super.key, this.semanticLabel});

  @override
  Widget build(BuildContext context) {
    return Semantics(
      header: false,
      label: semanticLabel,
      child: Text(text, style: Theme.of(context).textTheme.labelSmall),
    );
  }
}
