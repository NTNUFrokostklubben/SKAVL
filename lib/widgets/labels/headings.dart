import 'package:flutter/material.dart';

/// Semantic LargeHeader component to represent headers
///
/// Acts as wrapper for [Text] and applies [titleLarge] from ThemeData
class LargeHeader extends StatelessWidget {
  final String text;
  const LargeHeader(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Semantics(
      header: true,
      child: Text(text, style: Theme.of(context).textTheme.titleLarge),
    );
  }
}

/// Semantic LargeHeader component to represent headers
/// Acts as wrapper for [Text] and applies [titleMedium] from ThemeData
class MediumHeader extends StatelessWidget {
  final String text;
  const MediumHeader(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Semantics(
      header: true,
      child: Text(text, style: Theme.of(context).textTheme.titleMedium),
    );
  }
}
