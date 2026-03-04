import 'dart:math' as math;
import 'package:flutter/cupertino.dart';

import '../proto/tiler.pb.dart';

/// Calculates a rectangle based on viewport and a transformation controller
/// This is used to determine what is visible or not within the scene.
Rect viewportRectInScene({
  required TransformationController controller,
  required Size viewportSize,
}) {
  final tl = controller.toScene(Offset.zero);
  final br = controller.toScene(Offset(viewportSize.width, viewportSize.height));
  return Rect.fromPoints(tl, br);
}

/// Determines if a panel is visible in the scene or not
bool panelIsVisible({
  required Rect viewportSceneRect,
  required Rect panelSceneRect,
}) {
  return viewportSceneRect.overlaps(panelSceneRect);
}