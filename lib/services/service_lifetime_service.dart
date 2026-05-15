import 'dart:async';
import 'dart:io';

import 'package:skavl/adapter/shutdown_adapter.dart';
import 'package:skavl/services/port_config_service.dart';
import 'package:skavl/services/service_manager.dart';
import 'package:skavl/util/network_util.dart';

/// Singleton service to handle the lifetime of all [ServiceManager].
class ServiceLifetimeService {
  static final ServiceLifetimeService _instance =
      ServiceLifetimeService._internal();

  factory ServiceLifetimeService() => _instance;

  ServiceLifetimeService._internal();

  late final ServiceManager _tiler;
  late final ServiceManager _anomaly;
  late final ServiceManager _report;

  final _statusController = StreamController<ServiceStatusEvent>.broadcast();

  Stream<ServiceStatusEvent> get statusStream => _statusController.stream;

  bool _initialized = false;

  static const _tilerName = 'skavl_tiler';
  static const _anomalyName = 'skavl_anomaly';
  static const _reportName = 'skavl_report';
  static const _allNames = [_tilerName, _anomalyName, _reportName];

  /// Initializes all backend services.
  ///
  /// Refactored from Main
  Future<void> initAll() async {
    if (_initialized) return;
    _initialized = true;

    await PortConfigService().initialize();

    _tiler = ServiceManager(
      Platform.isWindows
          ? 'services/tiler/server/skavl-tiler.exe'
          : 'services/tiler/server/skavl-tiler',
    );
    _anomaly = ServiceManager(
      Platform.isWindows
          ? 'services/skavl-anomaly/server/skavl-anomaly-detection-server.exe'
          : 'services/skavl-anomaly/server/skavl-anomaly-detection-server',
    );
    _report = ServiceManager(
      Platform.isWindows
          ? 'services/skavl-report/server/skavl-report-server.exe'
          : 'services/skavl-report/server/skavl-report-server',
    );

    _tiler.statusStream.listen(
      (s) => _statusController.add(ServiceStatusEvent(_tilerName, s)),
    );
    _anomaly.statusStream.listen(
      (s) => _statusController.add(ServiceStatusEvent(_anomalyName, s)),
    );
    _report.statusStream.listen(
      (s) => _statusController.add(ServiceStatusEvent(_reportName, s)),
    );

    await _startIfFree(_tiler, _tilerName, extraArgs: const []);
    await _startIfFree(_anomaly, _anomalyName, extraArgs: const ['server']);
    await _startIfFree(_report, _reportName, extraArgs: const []);
  }

  /// Checks if port is already in use
  Future<void> _startIfFree(
    ServiceManager manager,
    String name, {
    required List<String> extraArgs,
  }) async {
    final config = PortConfigService().getConfig(name);
    if (await NetworkUtil.isPortInUse(config.port)) return;
    await manager.start(
      args: [...extraArgs, '--port', config.port.toString(), '--local'],
    );
  }

  /// Send gRPC shutdown signal to all services
  Future<void> shutdownAll({
    Duration timeout = const Duration(milliseconds: 500),
  }) async {
    if (!_initialized) return;

    _tiler.markIntentionalShutdown();
    _anomaly.markIntentionalShutdown();
    _report.markIntentionalShutdown();

    await Future.wait(
      _allNames.map((name) {
        final config = PortConfigService().getConfig(name);
        return ShutdownAdapter.shutdown(
          config,
          timeout: timeout,
        ).catchError((_) {});
      }),
    );
  }
}

/// Event for when services change status.
class ServiceStatusEvent {
  final String serviceName;
  final ServiceStatus status;

  const ServiceStatusEvent(this.serviceName, this.status);
}
