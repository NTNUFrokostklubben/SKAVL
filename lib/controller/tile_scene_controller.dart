import 'package:flutter/cupertino.dart';
import 'package:fixnum/fixnum.dart';
import 'package:skavl/entity/view_mode.dart';
import '../proto/tiler.pbgrpc.dart';
import '../widgets/tiler/panel_placement.dart';

/// Controller that holds state for tiles in the viewport.
///
/// Currently only implemented as Side-by-side view, but can be expanded to support other layouts.
class TileSceneController extends ChangeNotifier {
  TileSceneController({required this.tilerClient});

  final TilerServiceClient tilerClient;

  final Map<String, DescribeSourceResponse> sourcesById = {};
  final List<String> sourceOrder = [];
  final Map<String, List<TileRef>> tilesBySourceId = {};
  final Map<String, List<TileRef>> previousTilesBySourceId = {};
  ViewMode viewMode = ViewMode.horizontal;

  SceneLayout? sceneLayout;

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  void _rebuildLayout() {
    final ordered = sourceOrder.map((id) => sourcesById[id]!).toList();

    if (viewMode == ViewMode.horizontal) {
      sceneLayout = layoutSideBySide(ordered);
    } else if (viewMode == ViewMode.vertical) {
      sceneLayout = layoutVertical(ordered);
    }

    notifyListeners();
  }

  /// Loads the Source descriptors for the given paths and initializes the scene layout.
  ///
  /// Stems from Proto DTO [DescribeSourceResponse]
  /// TODO(#85 adapter): Refactor this into adapter later
  Future<void> loadSources(List<String> paths) async {
    _isLoading = true;
    notifyListeners();

    final responses = await Future.wait(
      paths.map(
        (path) => tilerClient.describeSource(
          DescribeSourceRequest(source: SourceRef(sourcePath: path)),
        ),
      ),
    );

    sourcesById.clear();
    sourceOrder.clear();
    tilesBySourceId.clear();

    for (final resp in responses) {
      final sourceId = resp.descriptor.sourceId;
      sourcesById[sourceId] = resp;
      sourceOrder.add(sourceId);
      tilesBySourceId[sourceId] = <TileRef>[];
    }

    _rebuildLayout();

    _isLoading = false;
    notifyListeners();
  }

  /// Plans visible tiles based on viewport window.
  ///
  /// Takes [Rect] in scene coordinates and screenPixelsPerSourcePixel to determine which tiles to request from tiler.
  Future<void> planVisibleTiles({
    required Rect viewportSceneRectPx,
    required double screenPixelsPerSourcePixel,
  }) async {
    final layout = sceneLayout;
    if (layout == null) return;

    final futures = <Future<void>>[];

    for (final sourceId in sourceOrder) {
      final panelRect = layout.panelRects[sourceId];
      final desc = sourcesById[sourceId];

      if (panelRect == null || desc == null) continue;
      if (!panelRect.overlaps(viewportSceneRectPx)) continue;

      final intersection = panelRect.intersect(viewportSceneRectPx);

      final localRect = Rect.fromLTWH(
        intersection.left - panelRect.left,
        intersection.top - panelRect.top,
        intersection.width,
        intersection.height,
      );

      futures.add(
        _planOneSource(
          sourceId: sourceId,
          localViewportRectPx: localRect,
          screenPixelsPerSourcePixel: screenPixelsPerSourcePixel,
        ),
      );
    }

    await Future.wait(futures);
    notifyListeners();
  }

  /// Gets requested tiles based on sourceId. viewport size and SSP.
  ///
  /// SSP (screenPixelsPerSourcePixel) is used to determine the level of detail for the tiles.
  /// Sets old tiles as a cache to prevent flashing when swapping tilesets in the display.
  Future<void> _planOneSource({
    required String sourceId,
    required Rect localViewportRectPx,
    required double screenPixelsPerSourcePixel,
  }) async {
    final response = await tilerClient.planViewport(
      PlanViewportRequest(
        source: SourceRef(sourceId: sourceId),
        viewportSourceRectPx: RectPx()
          ..x = Int64(localViewportRectPx.left.floor())
          ..y = Int64(localViewportRectPx.top.floor())
          ..width = localViewportRectPx.width.ceil()
          ..height = localViewportRectPx.height.ceil(),
        screenPixelsPerSourcePixel: screenPixelsPerSourcePixel,
        prefetchMarginTiles: 0,
        queueMissingTiles: true,
      ),
    );

    previousTilesBySourceId[sourceId] = tilesBySourceId[sourceId] ?? [];
    tilesBySourceId[sourceId] = response.manifest.tiles;
  }
}
