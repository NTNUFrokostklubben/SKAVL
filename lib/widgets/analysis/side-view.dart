import 'dart:ffi' as fixnum;
import 'dart:math';
import 'dart:ui';

import 'package:fixnum/fixnum.dart';
import 'package:flutter/material.dart';
import 'package:grpc/grpc.dart';
import 'package:skavl/widgets/tiler/panel_placement.dart';

import '../../proto/tiler.pb.dart';
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
  late final Future<List<DescribeSourceResponse>> _descs;
  late Iterable<TileRef> _tiles;

  late final void Function() _tcListener;
  int _level = 0;
  int _factor = 1;
  double _ssp = 1.0;
  double _displayTileSize = 512;

  late final ClientChannel _channel;
  late final TilerServiceClient tilerClient;


  final imagePaths = [
    r'C:\Users\Admin\Documents\bachelor-thesis\ImageDataTest\test\HX-14365_073_001_14822.tif',
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

    _descs = Future.wait([getManifestForSource(imagePaths[0])]);

    // TODO: Write this in a more cohesive way
    _tcListener = () {
      final scale = _tc.value.getMaxScaleOnAxis();
      int maxLevel = 10;
      final minSsp = 1.0 / (1 << maxLevel);
      final sspCont = scale.clamp(minSsp, 1.0);

      _level = (log(1/sspCont)/ln2).round().clamp(0, maxLevel);
      _factor = 1 << _level;
      _ssp = 1.0 / _factor;
      _displayTileSize = 512 * _factor.toDouble();
    };

    _tc.addListener(_tcListener);
  }

  @override
  void dispose() {
    _tc.removeListener(_tcListener);
    _tc.dispose();
    _channel.shutdown();
    super.dispose();
  }

  // TODO: Potentially refactor if this method of getting source from manifest doesnt work well
  Future<DescribeSourceResponse> getManifestForSource(String path) async {
    final resp = await tilerClient.describeSource(
      DescribeSourceRequest(source: SourceRef(sourcePath: path)),
    );
    final d = resp;
    return d;
  }

  // TODO: Implement this once multiple tiles are loaded
  Future<void> planVisibleOnlyOnce(Size viewportSize) async {
    print(_tc.toScene(Offset.zero));
    print(_tc.toScene(Offset(viewportSize.width, viewportSize.height)));

    Rect vp = viewportRectInScene(controller: _tc, viewportSize: viewportSize);
  }

  Future<void> fetchVisibleTiles(Size viewportSize) async {
    print(_ssp);
    print(_factor);


    final r = await tilerClient.planViewport(
      PlanViewportRequest(
        // TODO: Refactor this to not describe first but to use the sourceId from the manifest
        source: SourceRef(sourceId: await getManifestForSource(imagePaths[0]).then((d) => d.descriptor.sourceId)),
        viewportSourceRectPx: RectPx()
          ..x = Int64(_tc.toScene(Offset.zero).dx.toInt())
          ..y = Int64(_tc.toScene(Offset.zero).dy.toInt())
          ..width = (_tc.toScene(Offset(viewportSize.width, viewportSize.height)).dx.toInt() - _tc.toScene(Offset.zero).dx.toInt())
          ..height = (_tc.toScene(Offset(viewportSize.width, viewportSize.height)).dy.toInt() - _tc.toScene(Offset.zero).dy.toInt()),
        screenPixelsPerSourcePixel: _ssp,
        prefetchMarginTiles: 1,
        queueMissingTiles: true,
      ),
    );

    setState(() {
      _tiles = r.manifest.tiles;
    });

    // print(_tiles);
  }

  @override
  Widget build(BuildContext context) {
    // Placeholder, real image sizes will populate this later

    return LayoutBuilder(
      builder: (context, constraints) {
        final viewportSize = constraints.biggest;

        return Stack(
          children: [
            FutureBuilder<List<DescribeSourceResponse>>(
              future: _descs,
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }
                // TODO: Refactor this, should not fetch here
                final descs = snapshot.data!;
                final placements = layoutSideBySide(descs);
                return InteractiveViewer(
                  transformationController: _tc,
                  minScale: 0.005,
                  maxScale: 3,
                  boundaryMargin: EdgeInsets.all(double.infinity),
                  constrained: false,
                  child: SizedBox(
                    width: placements.sceneSize.width,
                    height: placements.sceneSize.height,
                    child: Stack(
                      children: List.generate(descs.length, (i) {
                        final d = descs[i].descriptor;
                        int originX = d.sourceWidthPx * i;


                        if (d == null) return const SizedBox();
                        return Positioned.fromRect(
                          rect: placements.panelRects[d.sourceId]!,
                          child: TileLayer(
                            panelWidthPx: d.sourceWidthPx.toDouble(),
                            panelHeightPx: d.sourceHeightPx.toDouble(),
                            tileSizePx: _displayTileSize,
                            tiles: _tiles,
                            originX: originX.toDouble(),
                            originY: 0,
                          ),
                        );
                      }),
                    ),
                  ),
                );
              },
            ),
            Positioned(
              left: 12,
              top: 12,
              child: ElevatedButton(
                onPressed: () => fetchVisibleTiles(viewportSize),
                child: Text("data"),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _placeholder(String imgName, {double w = 512, double h = 512}) {
    return Container(
      color: Colors.blue,
      width: w,
      height: h,
      child: Text(
        imgName,
        style: DefaultTextStyle.of(context).style.apply(fontSizeFactor: 50),
      ),
    );
  }
}
