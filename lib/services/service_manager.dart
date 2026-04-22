
import 'dart:async';
import 'dart:io';
import 'package:path/path.dart' as path;

enum ServiceStatus { starting, running, stopped, notFound }

/// Manager for external services like tiler, anomaly module, report module etc.
///
/// Responsible for starting, stopping and monitoring the status of these services.
class ServiceManager {
  final String _relativeExePath;
  Process? _process;
  final _statusController = StreamController<ServiceStatus>.broadcast();
  bool autoRestart;

  Stream<ServiceStatus> get statusStream => _statusController.stream;

  ServiceManager(this._relativeExePath, {this.autoRestart = true});

  /// Getter for the absolute path to the service executable.
  String get _exePath {
    final appDir = File(Platform.resolvedExecutable).parent.path;
    return path.normalize(path.join(appDir, _relativeExePath));
  }

  /// Starts service from stored executable path and monitors its status.
  Future<void> start({List<String> args = const []}) async {
    final exe = File(_exePath);
    if (!await exe.exists()) {
      _statusController.add(ServiceStatus.notFound);
      return;
    }

    _statusController.add(ServiceStatus.starting);
    _process = await Process.start(
      _exePath,
      args,
      workingDirectory: File(_exePath).parent.path,
    );
    _statusController.add(ServiceStatus.running);

    _process!.exitCode.then((_) {
      _statusController.add(ServiceStatus.stopped);
      // Restart on unexpected stop
      start();
    });
  }

  /// Kills process and stops monitoring.
  Future<void> stop() async {
    _process?.kill();
    _process = null;
  }

  /// Clears process from memory.
  void dispose() {
    stop();
    _statusController.close();
  }

}