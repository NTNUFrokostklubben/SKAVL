import 'dart:async';
import 'dart:io';
import 'dart:math';
import 'package:vector_math/vector_math_64.dart' show Vector3;

import 'package:flutter/material.dart';
import 'package:grpc/grpc.dart';
import 'package:skavl/controller/tile_scene_controller.dart';
import 'package:skavl/proto/tiler.pbgrpc.dart';
import 'package:skavl/util/viewport_math.dart';
import 'package:skavl/widgets/tiler/tile_layer.dart';
import 'package:skavl/theme/colors.dart';


// Maybe move this to a seperate class
class _GridPainter extends CustomPainter {
  const _GridPainter({
    required this.thinColor,
    required this.thickColor,
  });

  final Color thinColor; // Color of the thin lines in the grid
  final Color thickColor; // color of the thicker lines in the grid
  final double smallCellSize = 320.0;
  final double largeCellSize = 1600.0;

  @override
  void paint(Canvas canvas, Size size) {
    final thinPaint = Paint()
      ..color = thinColor
      ..strokeWidth = 0.5
      ..style = PaintingStyle.stroke;

    final thickPaint = Paint()
      ..color = thickColor
      ..strokeWidth = 1.0
      ..style = PaintingStyle.stroke;

    for (double x = 0; x <= size.width; x += smallCellSize) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), thinPaint);
    }
    for (double y = 0; y <= size.height; y += smallCellSize) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), thinPaint);
    }
    for (double x = 0; x <= size.width; x += largeCellSize) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), thickPaint);
    }
    for (double y = 0; y <= size.height; y += largeCellSize) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), thickPaint);
    }
  }

  @override
  bool shouldRepaint(_GridPainter old) =>
      old.smallCellSize != smallCellSize ||
      old.largeCellSize != largeCellSize ||
      old.thinColor != thinColor ||
      old.thickColor != thickColor;
}

/// A large fixed canvas size for the free view scene.
/// Images are placed within this space and can be dragged freely.
const double _kSceneSize = 320000.0; // Temp value, should be more dynamic

class FreeView extends StatefulWidget {
  const FreeView({super.key});

  @override
  State<FreeView> createState() => _FreeViewState();
}

class _FreeViewState extends State<FreeView> {
  late final TransformationController _tc;
  late final TileSceneController _sceneController;

  /// Current position of each source image in scene coordinates.
  final Map<String, Offset> _positions = {};

  /// Which source is currently being dragged.
  String? _draggingId;

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

  late final ClientChannel _channel;
  late final TilerServiceClient tilerClient;

  // temp file path
  final imagePaths = [
    r"C:\Users\sigbe\Documents\Skoleaar_25_26\Semester_6\Bachelor\HX_14365_NORDMORE_GSD10\RGB\HX-14365_001_009_00009.tif",
    r"C:\Users\sigbe\Documents\Skoleaar_25_26\Semester_6\Bachelor\HX_14365_NORDMORE_GSD10\RGB\HX-14365_001_010_00010.tif",
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
      if (!mounted) return;
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

  /// [scenePoint] is already in scene coordinates (after inverting the
  /// InteractiveViewer transform).
  String? _hitTest(Offset scenePoint) {
    // Iterate in reverse so the topmost (last drawn) image wins.
    for (final id in _sceneController.sourceOrder.reversed) {
      final pos = _positions[id];
      final desc = _sceneController.sourcesById[id];
      if (pos == null || desc == null) continue;

      final rect = Rect.fromLTWH(
        pos.dx,
        pos.dy,
        desc.descriptor.sourceWidthPx.toDouble(),
        desc.descriptor.sourceHeightPx.toDouble(),
      );

      if (rect.contains(scenePoint)) return id;
    }
    return null;
  }

  /// Convert a local widget-space offset to scene coordinates.
  Offset _toScene(Offset local) {
    final inverse = Matrix4.inverted(_tc.value);
    final vec = inverse.transform3(
      // Homogeneous 2D point
      Vector3(local.dx, local.dy, 0),
    );
    return Offset(vec.x, vec.y);
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final viewportSize = constraints.biggest;
        _lastViewportSize = viewportSize;

        return ListenableBuilder(
          listenable: _sceneController,
          builder: (context, _) {
            if (_sceneController.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (mounted) _scheduleViewportPlan();
            });

            return Listener(
              // Listener sits outside InteractiveViewer so it sees raw pointer
              // events before the viewer claims them for panning/zooming.
              onPointerDown: (event) {
                final scenePoint = _toScene(event.localPosition);
                _draggingId = _hitTest(scenePoint);
              },
              onPointerMove: (event) {
                if (_draggingId == null) return;
                final scale = _tc.value.getMaxScaleOnAxis();
                setState(() {
                  _positions[_draggingId!] =
                      _positions[_draggingId!]! + event.delta / scale;
                });
                _scheduleViewportPlan();
              },
              onPointerUp: (_) => _draggingId = null,
              onPointerCancel: (_) => _draggingId = null,
              child: InteractiveViewer(
                transformationController: _tc,
                minScale: 0.005,
                maxScale: 4,
                boundaryMargin: EdgeInsets.zero,
                constrained: false,
                panEnabled: _draggingId == null,
                child: SizedBox(
                  width: _kSceneSize,
                  height: _kSceneSize,
                  child: Stack(
                    children: [
                      // Grid fills the entire scene
                      Positioned.fill(
                        child: CustomPaint(painter: _GridPainter(
                          thinColor: Theme.of(context).brightness == Brightness.light
                                ? MyColors.secondaryBlack
                                : MyColors.primaryWhite,
                          thickColor:
                                Theme.of(context).brightness == Brightness.light
                                ? MyColors.secondaryBlack
                                : MyColors.primaryWhite,
                          )),
                      ),

                      // Image tiles
                      ..._sceneController.sourceOrder.map((sourceId) {
                        final pos = _positions[sourceId];
                        if (pos == null) return const SizedBox.shrink();

                        final desc = _sceneController.sourcesById[sourceId]!;
                        final imageW = desc.descriptor.sourceWidthPx.toDouble() - 2000;
                        final imageH = desc.descriptor.sourceHeightPx.toDouble() - 2000;

                        final rect = Rect.fromLTWH(
                          pos.dx,
                          pos.dy,
                          imageW,
                          imageH,
                        );

                        final tiles =
                            _sceneController.tilesBySourceId[sourceId] ??
                            const <TileRef>[];
                        final prevTiles =
                            _sceneController
                                .previousTilesBySourceId[sourceId] ??
                            const <TileRef>[];

                        final isDragging = _draggingId == sourceId;

                        return Positioned(
                          left: pos.dx,
                          top: pos.dy,
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: isDragging
                                    ? Colors.blueAccent
                                    : Colors.white24,
                                width: isDragging ? 2 : 1,
                              ),
                            ),
                            child: TileLayer(
                              panelWidthPx: imageW,
                              panelHeightPx: imageH,
                              tileSizePx: _committedDisplayTileSize,
                              tiles: tiles,
                              originX: rect.left,
                              originY: rect.top,
                              previousTiles: prevTiles,
                              previousTileSizePx:
                                  _previousCommittedDisplayTileSize,
                            ),
                          ),
                        );
                      }),
                    ],
                  ),
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

        final readyTiles = _sceneController.sourceOrder
            .expand((id) => _sceneController.tilesBySourceId[id] ?? [])
            .where((t) => t.state == TileState.TILE_STATE_READY);

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
