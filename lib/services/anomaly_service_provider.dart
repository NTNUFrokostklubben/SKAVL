import 'package:flutter/cupertino.dart';
import 'package:grpc/grpc.dart';
import 'package:skavl/controller/anomaly_detector_controller.dart';
import 'package:skavl/proto/anomaly.pbgrpc.dart';

/// Servicer provider for Anomaly Detection
///
/// Lives as a provider to make it available through the entire application
/// Uses hardcoded port and host for now, but is expandable.
class AnomalyServiceProvider extends ChangeNotifier {

  AnomalyServiceProvider() {
    _channel = ClientChannel(
      _host,
      port: _port,
      options: const ChannelOptions(credentials: ChannelCredentials.insecure()),
    );

    controller = AnomalyDetectorController(
      anomalyDetectorClient: AnomalyDetectorServiceClient(_channel),
    );
  }

  static const String _host = "127.0.0.1";
  static const int _port = 50052;

  late final ClientChannel _channel;
  late final AnomalyDetectorController controller;



  @override
  void dispose() {
    _channel.shutdown();
    super.dispose();
  }
}
