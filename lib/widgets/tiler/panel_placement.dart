import 'dart:ui';

import 'package:skavl/proto/tiler.pb.dart';

/// Class for pre-determining panel sizes for rendering
///
/// Might be deprecated soon, unsure if this will be used in final solution, but for testing it makes sense.
class SceneLayout {
  SceneLayout({required this.sceneSize, required this.panelRects});
  final Size sceneSize;
  final Map<String, Rect> panelRects;
}

SceneLayout layoutSideBySide(List<DescribeSourceResponse> manifests) {
  double x = 0.0;
  double maxH = 0.0;
  final rects = <String, Rect>{};

  for (final m in manifests) {
    final w = m.descriptor.sourceWidthPx.toDouble();
    final h = m.descriptor.sourceHeightPx.toDouble();
    rects[m.descriptor.sourceId] = Rect.fromLTWH(x, 0.0, w, h);
    x += w;
    if (h > maxH) maxH = h;
  }

  return SceneLayout(sceneSize: Size(x, maxH), panelRects: rects);
}