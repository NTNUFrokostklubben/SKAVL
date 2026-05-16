

import 'package:grpc/grpc.dart';
import 'package:skavl/entity/service_port_config.dart';
import 'package:skavl/proto/shutdown.pbgrpc.dart';

/// Adapter to handle shutdown of processes over gRPC
class ShutdownAdapter {

  /// Fires graceful shutdown RPC to target defined in [ServicePortConfig].
  static Future<void> shutdown(
      ServicePortConfig config, {
        Duration timeout = const Duration(milliseconds: 500),
      }) async {
    final channel = ClientChannel(
      config.ip,
      port: config.port,
      options: const ChannelOptions(credentials: ChannelCredentials.insecure()),
    );
    try {
      final client = ShutdownServiceClient(channel);
      await client.shutdown(ShutdownRequest()).timeout(timeout);
    } finally {
      await channel.shutdown();
    }
  }
}