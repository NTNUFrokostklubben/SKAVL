import 'package:fixnum/fixnum.dart';
import 'package:grpc/grpc.dart';
import 'package:skavl/proto/tiler.pbgrpc.dart';

/// Only used to test basic grpc communication. Will be replaced in future commit.
Future<void> grpcTest({
  required String host,
  int port = 50051,
}) async {
  final channel = ClientChannel(
    host,
    port: port,
    options: const ChannelOptions(
      credentials: ChannelCredentials.insecure(),
    ),
  );

  // final client = ProgressServiceClient(channel);
  final client = TilerServiceClient(channel);

  final req = DescribeSourceRequest()..source = (SourceRef()..sourcePath = r'C:\Users\Admin\Documents\bachelor-thesis\ImageDataTest\test\HX-14365_073_003_14824.tif');

  try {
    final describeReq = DescribeSourceRequest()
      ..source = (SourceRef()
        ..sourcePath = r'C:\Users\Admin\Documents\bachelor-thesis\ImageDataTest\test\HX-14365_073_003_14824.tif');

    final describeRes = await client.describeSource(describeReq);
    final sourceId = describeRes.descriptor.sourceId;

    final planReq = PlanViewportRequest()
      ..source = (SourceRef()..sourceId = sourceId)
      ..viewportSourceRectPx = (RectPx()
        ..x = Int64(0)
        ..y = Int64(0)
        ..width = 1024
        ..height = 768)
      ..screenPixelsPerSourcePixel = 1
      ..prefetchMarginTiles = 0
      ..queueMissingTiles = true;

    final planRes = await client.planViewport(planReq);

    final tiles = planRes.manifest.tiles;
    final level = planRes.manifest.selectedLevel;
    final ready = tiles.where((t) => t.state == TileState.TILE_STATE_READY).length;
    final missing = tiles.where((t) => t.state == TileState.TILE_STATE_MISSING).length;

    print('PlanViewport: level=$level tiles=${tiles.length} ready=$ready missing=$missing');
    if (tiles.isNotEmpty) {
      final t0 = tiles.first;
      print('First tile: L=${t0.coord.level} x=${t0.coord.x} y=${t0.coord.y} prefetch=${t0.isPrefetch}');
    }
  } on GrpcError catch (e) {
    print('GrpcError: code=${e.codeName} message=${e.message}');
  } finally {
    await channel.shutdown();
  }
}