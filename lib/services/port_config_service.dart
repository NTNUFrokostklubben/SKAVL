import 'dart:convert';
import 'dart:io';
import 'package:path/path.dart' as path;
import '../entity/service_port_config.dart';

/// Service for managing port configurations.
class PortConfigService {
  static final PortConfigService _instance = PortConfigService._internal();

  factory PortConfigService() => _instance;

  PortConfigService._internal();

  late List<ServicePortConfig> _configs;

  List<ServicePortConfig> get configs => List.unmodifiable(_configs);

  /// Service default values
  static const List<ServicePortConfig> _defaults = [
    ServicePortConfig(name: 'skavl_tiler', ip: '127.0.0.1', port: 50051),
    ServicePortConfig(name: 'skavl_anomaly', ip: '127.0.0.1', port: 50052),
    ServicePortConfig(name: 'skavl_report', ip: '127.0.0.1', port: 50053),
  ];

  /// Gets normalized filepath to where the process is running
  String get _filePath {
    final appDir = File(Platform.resolvedExecutable).parent.path;
    return path.normalize(path.join(appDir, 'ports.json'));
  }

  /// Loads [ServicePortConfig] configurations from file.
  Future<List<ServicePortConfig>> _loadFromFile() async {
    final file = File(_filePath);
    final content = await file.readAsString();
    final jsonList = jsonDecode(content) as List<dynamic>;
    return jsonList
        .map((e) => ServicePortConfig.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  /// Saves current [ServicePortConfig] configurations to file.
  Future<void> _saveToFile() async {
    final content = const JsonEncoder.withIndent(
      '  ',
    ).convert(_configs.map((c) => c.toJson()).toList());
    await File(_filePath).writeAsString(content);
  }

  /// Initializes the [ServicePortConfig] by loading from ports.json or creating defaults.
  ///
  /// If the file does not exist, writes defaults.
  /// If the file exists but is missing entries, appends the missing defaults.
  Future<void> initialize() async {
    final file = File(_filePath);
    if (!await file.exists()) {
      _configs = List.from(_defaults);
      await _saveToFile();
      return;
    }

    _configs = await _loadFromFile();
    bool modified = false;
    for (final defaultConfig in _defaults) {
      if (!_configs.any((c) => c.name == defaultConfig.name)) {
        _configs.add(defaultConfig);
        modified = true;
      }
    }

    if (modified) {
      await _saveToFile();
    }
  }

  /// Updates a [ServicePortConfig] by name and saves to file.
  Future<void> updateConfig(String name, ServicePortConfig updated) async {
    final index = _configs.indexWhere((c) => c.name == name);
    _configs[index] = updated;
    await _saveToFile();
  }

  /// Returns the [ServicePortConfig] for a given service name, or null if not found.
  ServicePortConfig getConfig(String name) {
    return _configs.firstWhere((c) => c.name == name);
  }
}
