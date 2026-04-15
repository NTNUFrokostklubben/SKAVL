import 'dart:ui';
import 'package:skavl/proto/tiler.pb.dart';

// TODO: Add a greater protection of image quantity

/// Class for pre-determining panel sizes for rendering
///
/// Might be deprecated soon, unsure if this will be used in final solution, but for testing it makes sense.
class SceneLayout {
  SceneLayout({required this.sceneSize, required this.panelRects});
  final Size sceneSize;
  final Map<String, Rect> panelRects;
}

/// Horizontally stacked image layout.
///
/// Will only populate grid fully if there are enough images before and after.
SceneLayout layoutHorizontal(List<DescribeSourceResponse> manifests) {
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

/// Vertically stacked images, top to bottom.
///
/// Will only populate grid fully if there are enough images before and after.
SceneLayout layoutVertical(List<DescribeSourceResponse> manifests) {
  double y = 0.0;
  double maxW = 0.0;
  final rects = <String, Rect>{};
  for (final m in manifests) {
    final w = m.descriptor.sourceWidthPx.toDouble();
    final h = m.descriptor.sourceHeightPx.toDouble();

    rects[m.descriptor.sourceId] = Rect.fromLTWH(0.0, y, w, h);

    y += h;
    if (w > maxW) maxW = w;
  }

  return SceneLayout(sceneSize: Size(maxW, y), panelRects: rects);
}

/// 2x2 image grid layout.
///
/// Will only populate grid fully if there are enough images before and after.
SceneLayout layoutGridSmall(List<DescribeSourceResponse> manifests) {
  if (manifests.isEmpty) {
    return SceneLayout(sceneSize: Size.zero, panelRects: {});
  }

  double maxW = 0.0;
  double maxH = 0.0;

  for (final m in manifests) {
    final w = m.descriptor.sourceWidthPx.toDouble();
    final h = m.descriptor.sourceHeightPx.toDouble();

    if (w > maxW) maxW = w;
    if (h > maxH) maxH = h;
  }

  final rects = <String, Rect>{};

  for (int i = 0; i < manifests.length; i++) {
    final m = manifests[i];

    final col = i % 2;
    final row = i ~/ 2;

    rects[m.descriptor.sourceId] = Rect.fromLTWH(
      col * maxW,
      row * maxH,
      maxW,
      maxH,
    );
  }

  return SceneLayout(sceneSize: Size(2 * maxW, 2 * maxH), panelRects: rects);
}

/// 3x3 image grid layout.
///
/// Will only populate grid fully if there are enough images before and after.
SceneLayout layoutGridBig(List<DescribeSourceResponse> manifests) {
  if (manifests.isEmpty) {
    return SceneLayout(sceneSize: Size.zero, panelRects: {});
  }

  const cols = 3;
  const rows = 3;

  double maxW = 0.0;
  double maxH = 0.0;

  for (final m in manifests) {
    final w = m.descriptor.sourceWidthPx.toDouble();
    final h = m.descriptor.sourceHeightPx.toDouble();

    if (w > maxW) maxW = w;
    if (h > maxH) maxH = h;
  }

  final rects = <String, Rect>{};

  for (int i = 0; i < manifests.length; i++) {
    final m = manifests[i];

    final col = i % cols;
    final row = i ~/ cols;

    final x = col * maxW;
    final y = row * maxH;

    rects[m.descriptor.sourceId] = Rect.fromLTWH(x, y, maxW, maxH);
  }

  return SceneLayout(
    sceneSize: Size(cols * maxW, rows * maxH),
    panelRects: rects,
  );
}
