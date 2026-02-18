import 'package:flutter/material.dart';

/// Helper function for navigating to page
///
///
/// [context] is the BuildContext of the current widget, used to access the Navigator and perform navigation.
/// [page] is the page to navigate to
void navigateTo(BuildContext context, Widget page) {
  Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => page,
      )
  );
}