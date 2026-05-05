import 'dart:convert';
import 'dart:io';
import 'package:path/path.dart' as p;

/// Service for managing the history of anomaly types classified by the user.
class AnomalyTypeHistoryService {
  static final AnomalyTypeHistoryService _instance =
      AnomalyTypeHistoryService._internal();

  factory AnomalyTypeHistoryService() => _instance;

  AnomalyTypeHistoryService._internal();

  static const _fileName = 'anomaly_types.json';

  List<String> _anomalyTypes = [];

  List<String> get anomalyTypes => List.unmodifiable(_anomalyTypes);

  String get _filePath {
    final exeDir = p.dirname(Platform.resolvedExecutable);
    return p.join(exeDir, _fileName);
  }

  /// Load anomaly types from disk.
  Future<void> load() async {
    final file = File(_filePath);
    if (!await file.exists()) {
      _anomalyTypes = [];
      return;
    }
    try {
      final content = await file.readAsString();
      final decoded = jsonDecode(content);
      if (decoded is List) {
        _anomalyTypes = decoded.cast<String>();
      }
    } catch (_) {
      _anomalyTypes = [];
    }
  }

  /// Add classification string if one doesn't already exist.
  Future<void> add(String classification) async {
    final trimmed = classification.trim();
    if (trimmed.isEmpty) return;
    if (_anomalyTypes.contains(trimmed)) return;
    _anomalyTypes.add(trimmed);
    await _save();
  }

  /// Saves updated anomaly types to file
  Future<void> _save() async {
    final file = File(_filePath);
    final content = const JsonEncoder.withIndent('  ').convert(_anomalyTypes);
    await file.writeAsString(content);
  }
}
