import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:grpc/grpc.dart';

import 'package:skavl/controller/tile_scene_controller.dart';
import 'package:skavl/proto/tiler.pbgrpc.dart';
import 'package:skavl/util/viewport_math.dart';
import 'package:skavl/widgets/tiler/tile_layer.dart';

abstract class BaseTileView extends StatefulWidget {
  const BaseTileView({super.key});
}

abstract class BaseTileViewState<T extends BaseTileView> extends State<T> {

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

  late final void Function() tcListener; // Listener for TransformationController to trigger tile loading on zoom/pan

  Rect getSceneRect(); // Scene bounds (used for sizing the canvas)
  Map<String, Rect>? getCustomRects(); // Optional custom rects (FreeView uses this)
  Rect? resolveRectSafe(String sourceId); // Resolve sourceId to a rect, but return null if not available
  List<String> getImagePaths(); // Provide image paths

  Widget buildViewport(Widget child); // Wrap the scene (used for grid / gestures / etc.)

  // --------------------------------------------------

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

            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (mounted) scheduleViewportPlan();
            });

            final sceneRect = getSceneRect();
            final tileStack = SizedBox(
              width: sceneRect.width,
              height: sceneRect.height,
              child: Stack(children: buildTiles()),
            );

            // The subclass is responsible for wrapping with InteractiveViewer
            return buildViewport(tileStack);
          },
        );
      },
    );
  }


  List<Widget> buildTiles() {
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
          previousTiles: prevTiles,
          previousTileSizePx: previousCommittedTileSize,
        ),
      );
    }).toList();
  }

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
