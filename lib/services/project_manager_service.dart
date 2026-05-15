import 'package:flutter/cupertino.dart';
import 'package:skavl/entity/project_metadata.dart';

/// Service that holds current project in the context
///
/// Used for global project metadata access.
class ProjectManagerService extends ChangeNotifier {
  ProjectMetadata? _loadedProject;
  String? _filePath;

  /// Get loaded project
  ProjectMetadata? get loadedProject => _loadedProject;

  /// Get project filepath
  String? get filePath => _filePath;

  /// Return if project i sloaded
  bool get hasProject => _loadedProject != null;

  /// Set project for context
  void setProject(ProjectMetadata project, String filePath) {
    _loadedProject = project;
    _filePath = filePath;
    notifyListeners();
  }

  /// Clear project for context
  void clearProject() {
    _loadedProject = null;
    _filePath = null;
    notifyListeners();
  }


}
