import 'package:flutter/cupertino.dart';
import 'package:grpc/grpc.dart';
import 'package:skavl/controller/anomaly_detector_controller.dart';
import 'package:skavl/services/port_config_service.dart';

import '../proto/anomaly.pbgrpc.dart';

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

  final anomalyConfig = PortConfigService().getConfig("skavl_anomaly");
  late final String _host = anomalyConfig.ip;
  late final int _port = anomalyConfig.port;

  late final ClientChannel _channel;
  late final AnomalyDetectorController controller;



  @override
  void dispose() {
    _channel.shutdown();
    super.dispose();
  }
}
