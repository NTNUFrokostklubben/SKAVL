import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:grpc/grpc.dart';
import 'package:path/path.dart' as path;

import 'package:skavl/controller/tile_scene_controller.dart';
import 'package:skavl/entity/project_metadata.dart';
import 'package:skavl/proto/tiler.pbgrpc.dart';
import 'package:skavl/util/viewport_math.dart';
import 'package:skavl/widgets/tiler/tile_layer.dart';
import 'package:vector_math/vector_math_64.dart';

/// The base class for analysis views, which provides common functionality for both StaticView and FreeView.
///
/// This includes the gRPC client setup, the tile loading logic based on the viewport, and the common build method that renders the tiles in a stack.
abstract class BaseAnalysisView extends StatefulWidget {
  const BaseAnalysisView({super.key});
}

/// The state for BaseAnalysisView, which manages the tile loading and rendering logic.
abstract class BaseTileViewState<T extends BaseAnalysisView> extends State<T> {

  // Controllers
  late final TransformationController tc;
  late final TileSceneController sceneController;

  // gRPC client setup
  late final ClientChannel channel;
  late final TilerServiceClient tilerClient;

  // Tile scaling parameters
  int factor = 1;
  double ssp = 1.0;

  // Committed values that are only updated after the debounce
  int committedFactor = 1;
  double committedTileSize = 512;
  double previousCommittedTileSize = 512;

  // Debounce / planning
  Timer? planDebounce;
  bool planInFlight = false;
  int planGeneration = 0;
  Size? lastViewportSize;

  // Fit-to-scene on load
  bool pendingFitToScene = false;

  late final void Function() tcListener; // Listener for TransformationController to trigger tile loading on zoom/pan

  Rect getSceneRect(); // Scene bounds (used for sizing the canvas)
  Map<String, Rect>? getCustomRects(); // Optional custom rects (FreeView uses this)
  Rect? resolveRectSafe(String sourceId); // Resolve sourceId to a rect, but return null if not available
  List<String> getImagePaths(); // Provide image paths

  Widget buildViewport(Widget child); // Wrap the scene (used for grid / gestures / etc.)

  /// Returns [count] full paths centred on the current page.
  ///
  /// Uses [project.allSets] as the ordering source — the same object references
  /// appear in [anomaliesInRange], so indexOf is reliable regardless of filenames.
  List<String> getWindowPaths(ProjectMetadata project, int count) {
    final anomalies = project.anomaliesInRange;
    if (anomalies.isEmpty || project.currentPage >= anomalies.length) return [];

    final center = anomalies[project.currentPage];
    final centerIdx = project.allSets.indexOf(center);
    if (centerIdx == -1) return [];

    final folder = project.imageFolderPath;
    final before = count ~/ 2;
    final after  = count - before - 1;
    final from = (centerIdx - before).clamp(0, project.allSets.length - 1);
    final to   = (centerIdx + after).clamp(0, project.allSets.length - 1);

    return project.allSets
        .sublist(from, to + 1)
        .map((s) => path.join(folder, s.imageName))
        .toList();
  }

  @override
  void initState() {
    super.initState();

    tc = TransformationController();

    channel = ClientChannel(
      '127.0.0.1',
      port: 50051,
      options: const ChannelOptions(credentials: ChannelCredentials.insecure()),
    );

    // Setup of the controllers
    tilerClient = TilerServiceClient(channel);
    sceneController = TileSceneController(tilerClient: tilerClient);

    // Transformation listener
    tcListener = () {
      final scale = tc.value.getMaxScaleOnAxis();

      int maxLevel = 4;
      final minSsp = 1.0 / (1 << maxLevel);
      final sspCont = scale.clamp(minSsp, 1.0);

      factor = 1 << (log(1 / sspCont) / ln2).round().clamp(0, maxLevel);
      ssp = 1.0 / factor;

      scheduleViewportPlan();
    };

    tc.addListener(tcListener);
  }

  @override
  void dispose() {
    planDebounce?.cancel();
    tc.removeListener(tcListener);
    tc.dispose();
    sceneController.dispose();
    channel.shutdown();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        lastViewportSize = constraints.biggest;

        return ListenableBuilder(
          listenable: sceneController,
          builder: (context, _) {
            if (sceneController.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (sceneController.sourceOrder.isEmpty) {
              return const Center(child: Text('No anomalies match the current sensitivity.'));
            }

            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (!mounted) return;
              if (pendingFitToScene) fitViewportToScene();
              scheduleViewportPlan();
            });

            final windowSize = sceneController.sourceOrder.length;
            final highlightIdx = (windowSize ~/ 2).clamp(0, windowSize - 1);

            final sceneRect = getSceneRect();
            final tileStack = SizedBox(
              width: sceneRect.width,
              height: sceneRect.height,
              child: Stack(children: buildTiles(
                highlightedSourceId: sceneController.sourceOrder.isNotEmpty
                    ? sceneController.sourceOrder[highlightIdx]
                    : null,
              )),
            );
            // The subclass is responsible for wrapping with InteractiveViewer
            return buildViewport(tileStack);
          },
        );
      },
    );
  }

  /// Build the list of tile layers for the current scene, based on the loaded sources and their corresponding tiles.
  List<Widget> buildTiles({String? highlightedSourceId}) {
    return sceneController.sourceOrder.map((sourceId) {
      final rect = resolveRectSafe(sourceId);
      if (rect == null) return const SizedBox.shrink();

      final desc = sceneController.sourcesById[sourceId]!;
      final tiles =
          sceneController.tilesBySourceId[sourceId] ?? const <TileRef>[];
      final prevTiles =
          sceneController.previousTilesBySourceId[sourceId] ??
          const <TileRef>[];

      return Positioned.fromRect(
        rect: rect,
        child: TileLayer(
          panelWidthPx: desc.descriptor.sourceWidthPx.toDouble(),
          panelHeightPx: desc.descriptor.sourceHeightPx.toDouble(),
          tileSizePx: committedTileSize,
          tiles: tiles,
          originX: rect.left,
          originY: rect.top,
          highlighted: sourceId == highlightedSourceId,
          previousTiles: prevTiles,
          previousTileSizePx: previousCommittedTileSize,
        ),
      );
    }).toList();
  }

  /// Fits the viewport to show the full scene, centered, at 90% of the fit-to-contain scale.
  ///
  /// Called once after sources load so the primary image is visible on first render.
  void fitViewportToScene() {
    final viewportSize = lastViewportSize;
    if (viewportSize == null) return;

    Rect sceneRect;
    try {
      sceneRect = getSceneRect();
    } catch (_) {
      return;
    }
    if (sceneRect.isEmpty) return;

    pendingFitToScene = false;

    final scaleX = viewportSize.width / sceneRect.width;
    final scaleY = viewportSize.height / sceneRect.height;
    final scale = min(scaleX, scaleY) * 0.9;

    final dx = (viewportSize.width - sceneRect.width * scale) / 2 - sceneRect.left * scale;
    final dy = (viewportSize.height - sceneRect.height * scale) / 2 - sceneRect.top * scale;

    tc.value = Matrix4.identity()
      ..translateByVector3(Vector3(dx, dy, 0.0))
      ..scaleByVector3(Vector3.all(scale));
  }

  /// Trigger viewport redraw based on debounced notification from TransformationController.
  ///
  /// Ensures viewport isn't redrawn every frame and doesnt overload request pipeline.
  void scheduleViewportPlan({
    Duration debounceTime = const Duration(milliseconds: 180),
  }) {
    final viewportSize = lastViewportSize;
    if (viewportSize == null) return;

    planDebounce?.cancel();
    final requestGeneration = ++planGeneration;

    planDebounce = Timer(debounceTime, () async {
      if (!mounted) return;
      if (requestGeneration != planGeneration) return;
      if (planInFlight) return;

      final requestFactor = factor;
      final requestSsp = ssp;

      planInFlight = true;

      try {
        final viewportRect = viewportRectInScene(
          controller: tc,
          viewportSize: viewportSize,
        );

        await sceneController.planVisibleTiles(
          viewportSceneRectPx: viewportRect,
          screenPixelsPerSourcePixel: requestSsp,
          customRects: getCustomRects(),
        );

        // To reduce hole flash, we wait for all tiles to be ready
        final readyTiles = sceneController.sourceOrder
            .expand((id) => sceneController.tilesBySourceId[id] ?? [])
            .where((t) => t.state == TileState.TILE_STATE_READY);

        // Precaching loaded tiles mitigate loading before image fully reads
        await Future.wait(
          readyTiles.map(
            (t) => precacheImage(FileImage(File(t.localPath)), context),
          ),
        );
      } finally {
        if (mounted) {
          planInFlight = false;

          setState(() {
            committedFactor = requestFactor;
            previousCommittedTileSize = committedTileSize;
            committedTileSize = 512 * committedFactor.toDouble();
          });
        }
      }
    });
  }
}
