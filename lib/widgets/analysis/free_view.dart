import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:grpc/grpc.dart';
import 'package:skavl/controller/tile_scene_controller.dart';
import 'package:skavl/proto/tiler.pbgrpc.dart';
import 'package:skavl/util/viewport_math.dart';
import 'package:skavl/widgets/tiler/tile_layer.dart';

class FreeView extends StatefulWidget {
  const FreeView({super.key});

  @override
  State<FreeView> createState() => _FreeViewState();
}

class _FreeViewState extends State<FreeView> {
  late final TransformationController _tc;
  late final TileSceneController _sceneController;

  final Map<String, Offset> _positions = {};

  // Listener for TransformationController to trigger tile loading on zoom/pan
  late final void Function() _tcListener;

  // Tile scaling parameters
  int _factor = 1;
  double _ssp = 1.0;

  // Committed values that are only updated after the debounce
  int _committedFactor = 1;
  double _committedDisplayTileSize = 512;
  double _previousCommittedDisplayTileSize = 512;

  // Debounce parameters for TransformationController viewport updating
  Timer? _planDebounce;
  bool _planInFlight = false;
  int _planGeneration = 0;
  Size? _lastViewportSize;

  // gRPC client setup
  late final ClientChannel _channel;
  late final TilerServiceClient tilerClient;

  final imagePaths = [
    r"C:\Users\sigbe\Documents\Skoleaar_25_26\Semester_6\Bachelor\HX_14365_NORDMORE_GSD10\RGB\HX-14365_001_009_00009.tif",
  ];

  @override
  void initState() {
    super.initState();
    _tc = TransformationController();

    _channel = ClientChannel(
      '127.0.0.1',
      port: 50051,
      options: const ChannelOptions(credentials: ChannelCredentials.insecure()),
    );
    tilerClient = TilerServiceClient(_channel);

    _sceneController = TileSceneController(tilerClient: tilerClient);

    _sceneController.loadSources(imagePaths).then((_) {
      setState(() {
        for (final id in _sceneController.sourceOrder) {
          _positions[id] = Offset(
            Random().nextDouble() * 2000,
            Random().nextDouble() * 2000,
          );
        }
      });
    });

    _tcListener = () {
      final scale = _tc.value.getMaxScaleOnAxis();
      int maxLevel = 4;
      final minSsp = 1.0 / (1 << maxLevel);
      final sspCont = scale.clamp(minSsp, 1.0);

      _factor = 1 << (log(1 / sspCont) / ln2).round().clamp(0, maxLevel);
      _ssp = 1.0 / _factor;

      _scheduleViewportPlan();
    };

    _tc.addListener(_tcListener);
  }

  @override
  void dispose() {
    _planDebounce?.cancel();
    _tc.removeListener(_tcListener);
    _tc.dispose();
    _sceneController.dispose();
    _channel.shutdown();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final viewportSize = constraints.biggest;
        _lastViewportSize = viewportSize;

        return ListenableBuilder(
          listenable: _sceneController,
          builder: (context, child) {
            // Displays spinner if image cant load (usually tiler not running)
            if (_sceneController.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            // Callback once initial plan has been set
            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (mounted) _scheduleViewportPlan();
            });

            final layout = _sceneController.sceneLayout!;

            return InteractiveViewer(
              transformationController: _tc,
              minScale: 0.005,
              maxScale: 3,
              boundaryMargin: EdgeInsets.all(double.infinity),
              constrained: false,
              child: SizedBox(
                width: layout.sceneSize.width,
                height: layout.sceneSize.height,
                child: Stack(
                  children: _sceneController.visibleSourceIds.map((sourceId) {

                    final pos = _positions[sourceId]!;
                    final desc = _sceneController.sourcesById[sourceId]!;

                    final rect = Rect.fromLTWH(
                      pos.dx,
                      pos.dy,
                      desc.descriptor.sourceWidthPx.toDouble(),
                      desc.descriptor.sourceHeightPx.toDouble(),
                    );

                    final tiles =
                        _sceneController.tilesBySourceId[sourceId] ??
                        const <TileRef>[];
                    final prevTiles =
                        _sceneController.previousTilesBySourceId[sourceId] ??
                        const <TileRef>[];

                    return Positioned(
                      left: pos.dx,
                      top: pos.dy,
                      child: GestureDetector(
                        onPanUpdate: (details) {
                          setState(() {
                            _positions[sourceId] =
                                _positions[sourceId]! + details.delta;
                          });
                        },
                        child: TileLayer(
                          panelWidthPx: desc.descriptor.sourceWidthPx
                              .toDouble(),
                          panelHeightPx: desc.descriptor.sourceHeightPx
                              .toDouble(),
                          tileSizePx: _committedDisplayTileSize,
                          tiles: tiles,
                          originX: rect.bottom,
                          originY: rect.right,
                          previousTiles: prevTiles,
                          previousTileSizePx: _previousCommittedDisplayTileSize,
                          clip: false,
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            );
          },
        );
      },
    );
  }

  /// Triggers a viewport redraw based on debounced notification from TransformationController
  ///
  /// Ensures viewport isn't redrawn every frame and doesnt overload request pipeline.
  void _scheduleViewportPlan({
    Duration debounceTime = const Duration(milliseconds: 180),
  }) {
    final viewportSize = _lastViewportSize;
    if (viewportSize == null) return;

    _planDebounce?.cancel();
    final requestGeneration = ++_planGeneration;

    _planDebounce = Timer(debounceTime, () async {
      if (!mounted) return;
      if (requestGeneration != _planGeneration) return;
      if (_planInFlight) return;

      final requestFactor = _factor;
      final requestSsp = _ssp;

      _planInFlight = true;
      try {
        final viewportRect = viewportRectInScene(
          controller: _tc,
          viewportSize: viewportSize,
        );

        final customRects = <String, Rect>{};

        for (final sourceId in _sceneController.sourceOrder) {
          final pos = _positions[sourceId];
          final desc = _sceneController.sourcesById[sourceId];

          if (pos == null || desc == null) continue;

          customRects[sourceId] = Rect.fromLTWH(
            pos.dx,
            pos.dy,
            desc.descriptor.sourceWidthPx.toDouble(),
            desc.descriptor.sourceHeightPx.toDouble(),
          );
        }

        await _sceneController.planVisibleTiles(
          viewportSceneRectPx: viewportRect,
          screenPixelsPerSourcePixel: requestSsp,
          customRects: customRects,
        );

        // To reduce hole flash, we wait for all tiles to be ready
        final readyTiles = _sceneController.sourceOrder
            .expand((id) => _sceneController.tilesBySourceId[id] ?? [])
            .where((t) => t.state == TileState.TILE_STATE_READY);

        // Precaching loaded tiles mitigate loading before image fully reads
        await Future.wait(
          readyTiles.map(
            (t) => precacheImage(FileImage(File(t.localPath)), context),
          ),
        );
      } finally {
        if (mounted) {
          _planInFlight = false;
          setState(() {
            _committedFactor = requestFactor;
            _previousCommittedDisplayTileSize = _committedDisplayTileSize;
            _committedDisplayTileSize = 512 * _committedFactor.toDouble();
          });
        }
      }
    });
  }
}
