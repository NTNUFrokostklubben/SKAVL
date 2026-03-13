import 'package:fixnum/fixnum.dart';
import 'package:grpc/grpc.dart';
import 'package:skavl/proto/tiler.pbgrpc.dart';

/// Basic client implementation to test basic communication to tiler.
///
/// Will be replaced in future
class TilerApi {
  TilerApi({required String host, required int port})
      : _channel = ClientChannel(
    host,
    port: port,
    options: const ChannelOptions(
      credentials: ChannelCredentials.insecure(),
    ),
  );

  final ClientChannel _channel;
  late final TilerServiceClient _stub = TilerServiceClient(_channel);

  Future<DescribeSourceResponse> describeSourceByPath(String sourcePath) {
    final req = DescribeSourceRequest()
      ..source = (SourceRef()..sourcePath = sourcePath);
    return _stub.describeSource(req);
  }

  Future<DescribeSourceResponse> describeSourceById(String sourceId) {
    final req = DescribeSourceRequest()
      ..source = (SourceRef()..sourceId = sourceId);
    return _stub.describeSource(req);
  }

  Future<DescribeSourceResponse> describeSource() {
    return _stub.describeSource(DescribeSourceRequest());
  }

  Future<PlanViewportResponse> planViewport({
    required String sourceId,
    required int viewportX0,
    required int viewportY0,
    required int viewportW0,
    required int viewportH0,
    required double screenPixelsPerSourcePixel,
    int prefetchMarginTiles = 1,
    bool queueMissingTiles = false,
  }) {
    final req = PlanViewportRequest()
      ..source = (SourceRef()..sourceId = sourceId)
      ..viewportSourceRectPx = (RectPx()
        ..x = Int64(viewportX0)
        ..y = Int64(viewportY0)
        ..width = viewportW0
        ..height = viewportH0)
      ..screenPixelsPerSourcePixel = screenPixelsPerSourcePixel
      ..prefetchMarginTiles = prefetchMarginTiles
      ..queueMissingTiles = queueMissingTiles;

    return _stub.planViewport(req);
  }

  Future<void> close() => _channel.shutdown();
}