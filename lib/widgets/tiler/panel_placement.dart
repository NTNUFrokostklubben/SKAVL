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

// Layout for a side by side horizontal view
SceneLayout layoutHorizontal(List<DescribeSourceResponse> manifests) {
  double x = 0.0;
  double maxH = 0.0;
  final rects = <String, Rect>{};

  final manifestsDisplay = manifests.take(3).toList(); // Temp, change later

  for (final m in manifestsDisplay) {
    final w = m.descriptor.sourceWidthPx.toDouble();
    final h = m.descriptor.sourceHeightPx.toDouble();
    rects[m.descriptor.sourceId] = Rect.fromLTWH(x, 0.0, w, h);
    x += w;
    if (h > maxH) maxH = h;
  }

  return SceneLayout(sceneSize: Size(x, maxH), panelRects: rects);
}

// Layout for a side by side vertical view
SceneLayout layoutVertical(List<DescribeSourceResponse> manifests) {
  double y = 0.0;
  double maxW = 0.0;
  final rects = <String, Rect>{};
  final manifestsDisplay = manifests.take(3).toList();

  for (final m in manifestsDisplay) {
    final w = m.descriptor.sourceWidthPx.toDouble();
    final h = m.descriptor.sourceHeightPx.toDouble();

    rects[m.descriptor.sourceId] = Rect.fromLTWH(0.0, y, w, h);

    y += h;
    if (w > maxW) maxW = w;
  }

  return SceneLayout(sceneSize: Size(maxW, y), panelRects: rects);
}

// Layout for a 2x2 grid view
SceneLayout layoutGridSmall(List<DescribeSourceResponse> manifests) {
  final selected = manifests.take(4).toList();

  if (selected.isEmpty) {
    return SceneLayout(sceneSize: Size.zero, panelRects: {});
  }

  double maxW = 0.0;
  double maxH = 0.0;

  for (final m in selected) {
    final w = m.descriptor.sourceWidthPx.toDouble();
    final h = m.descriptor.sourceHeightPx.toDouble();

    if (w > maxW) maxW = w;
    if (h > maxH) maxH = h;
  }

  final rects = <String, Rect>{};

  for (int i = 0; i < selected.length; i++) {
    final m = selected[i];

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

// Layout for a 3x3 grid view
SceneLayout layoutGridBig(List<DescribeSourceResponse> manifests) {
  final selected = manifests.take(9).toList();

  if (selected.isEmpty) {
    return SceneLayout(sceneSize: Size.zero, panelRects: {});
  }

  const cols = 3;
  const rows = 3;

  double maxW = 0.0;
  double maxH = 0.0;

  for (final m in selected) {
    final w = m.descriptor.sourceWidthPx.toDouble();
    final h = m.descriptor.sourceHeightPx.toDouble();

    if (w > maxW) maxW = w;
    if (h > maxH) maxH = h;
  }

  final rects = <String, Rect>{};

  for (int i = 0; i < selected.length; i++) {
    final m = selected[i];

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
