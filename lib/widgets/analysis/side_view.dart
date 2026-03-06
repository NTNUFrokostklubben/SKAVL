import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:grpc/grpc.dart';

import '../../controller/tile_scene_controller.dart';
import '../../proto/tiler.pbgrpc.dart';
import '../../util/viewport_math.dart';
import '../tiler/tile_layer.dart';

class SideView extends StatefulWidget {
  const SideView({super.key});

  @override
  State<SideView> createState() => _SideViewState();
}

class _SideViewState extends State<SideView> {
  late final TransformationController _tc;
  late final TileSceneController _sceneController;

  // Listener for TransformationController to trigger tile loading on zoom/pan
  late final void Function() _tcListener;

  // Tile scaling parameters
  int _level = 0;
  int _factor = 1;
  double _ssp = 1.0;
  double _displayTileSize = 512;

  // Debounce parameters for TransformationController viewport updating
  Timer? _planDebounce;
  bool _planInFlight = false;
  int _planGeneration = 0;
  Size? _lastViewportSize;

  // gRPC client setup
  late final ClientChannel _channel;
  late final TilerServiceClient tilerClient;

  final imagePaths = [
    r'C:\Users\Admin\Documents\bachelor-thesis\ImageDataTest\test\HX-14365_073_001_14822.tif',
    r'C:\Users\Admin\Documents\bachelor-thesis\ImageDataTest\test\HX-14365_073_002_14823.tif',
    r'C:\Users\Admin\Documents\bachelor-thesis\ImageDataTest\test\HX-14365_073_003_14824.tif',
    r'C:\Users\Admin\Documents\bachelor-thesis\ImageDataTest\test\HX-14365_073_004_14825.tif',
    r'C:\Users\Admin\Documents\bachelor-thesis\ImageDataTest\test\HX-14365_073_005_14826.tif',
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
    _sceneController.loadSources(imagePaths);

    _tcListener = () {
      final scale = _tc.value.getMaxScaleOnAxis();
      int maxLevel = 4;
      final minSsp = 1.0 / (1 << maxLevel);
      final sspCont = scale.clamp(minSsp, 1.0);

      _level = (log(1 / sspCont) / ln2).round().clamp(0, maxLevel);
      _factor = 1 << _level;
      _ssp = 1.0 / _factor;
      _displayTileSize = 512 * _factor.toDouble();

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

  Future<void> fetchVisibleTiles(Size viewportSize) async {

    final viewportRect = viewportRectInScene(
      controller: _tc,
      viewportSize: viewportSize,
    );

    await _sceneController.planVisibleTiles(
      viewportSceneRectPx: viewportRect,
      screenPixelsPerSourcePixel: _ssp,
    );
  }

  @override
  Widget build(BuildContext context) {
    // Placeholder, real image sizes will populate this later

    return LayoutBuilder(
      builder: (context, constraints) {
        final viewportSize = constraints.biggest;
        _lastViewportSize = viewportSize;

        return Stack(
            children: [
            ListenableBuilder(
            listenable: _sceneController,
            builder: (context, child) {
              if (_sceneController.isLoading || _sceneController.sceneLayout == null) {
                return const Center(child: CircularProgressIndicator());
              }
              bool _initialPlanDone = false;
              if (!_initialPlanDone && _sceneController.sceneLayout != null) {
                _initialPlanDone = true;
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  if (!mounted) return;
                  _scheduleViewportPlan();
                });
              }

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
                    children: _sceneController.sourceOrder.map((sourceId) {
                      final desc = _sceneController.sourcesById[sourceId]!;
                      final rect = layout.panelRects[sourceId]!;
                      final tiles = _sceneController.tilesBySourceId[sourceId] ?? const <TileRef>[];

                      return Positioned.fromRect(
                        rect: rect,
                        child: TileLayer(
                          panelWidthPx: desc.descriptor.sourceWidthPx.toDouble(),
                          panelHeightPx: desc.descriptor.sourceHeightPx.toDouble(),
                          tileSizePx: _displayTileSize,
                          tiles: tiles,
                          originX: rect.left,
                          originY: rect.top,
                        ),
                      );
                    }).toList(),
                  ),
                ),
              );
            }
        ),
        Positioned(
          left: 12,
          top: 12,
          child: ElevatedButton(
            onPressed: () => fetchVisibleTiles(viewportSize),
            child: Text("data"),
          ),
        )
        ,
        ]
        ,
        );
      },
    );
  }

  /// Triggers a viewport redraw based on debounced notification from TransformationController
  ///
  /// Ensures viewport isn't redrawn every frame and doesnt overload request pipeline.
  void _scheduleViewportPlan({Duration debounceTime = const Duration(milliseconds: 180)}) {
    final viewportSize = _lastViewportSize;
    if (viewportSize == null) return;

    _planDebounce?.cancel();
    final requestGeneration = ++_planGeneration;

    _planDebounce = Timer(debounceTime, () async {
      if (!mounted) return;
      if (requestGeneration != _planGeneration) return;
      if (_planInFlight) return;

      _planInFlight = true;
      try {
        final viewportRect = viewportRectInScene(
          controller: _tc,
          viewportSize: viewportSize,
        );

        await _sceneController.planVisibleTiles(
          viewportSceneRectPx: viewportRect,
          screenPixelsPerSourcePixel: _ssp,
        );
      } finally {
        _planInFlight = false;
      }
    });
  }
}
