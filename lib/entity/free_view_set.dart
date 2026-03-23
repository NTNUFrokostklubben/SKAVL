import 'package:flutter/material.dart';

/// A simple data class representing a layer in the free view, which can be positioned and scaled independently.
class FreeLayer {
  String sourceId;
  Offset position;
  double scale;

  FreeLayer({
    required this.sourceId,
    required this.position,
    required this.scale,
  });
}
