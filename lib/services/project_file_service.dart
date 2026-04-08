import 'dart:convert';
import 'dart:io';

import '../entity/project_metadata.dart';

/// Project file service class
///
/// Singleton for loads, saves and creating new projects to and from files.
class ProjectFileService {
  static final ProjectFileService _instance = ProjectFileService._internal();

  factory ProjectFileService() => _instance;

  ProjectFileService._internal();

  /// Load project metadata from file
  Future<ProjectMetadata> loadFromFile(String filePath) async {
    final file = File(filePath);
    final content = await file.readAsString();
    final json = jsonDecode(content) as Map<String, dynamic>;
    return ProjectMetadata.fromJson(json);
  }

  /// Save project metadata to file
  Future<void> saveToFile(String filePath, ProjectMetadata project) async {
    final file = File(filePath);
    final content = const JsonEncoder.withIndent(
      '  ',
    ).convert(project.toJson());
    await file.writeAsString(content);
  }

  /// Create new project file with given metadata and return the file path
  Future<String> createNewFile(
    String directoryPath,
    ProjectMetadata project,
  ) async {
    final filePath = '$directoryPath/${project.projectName}.skavl';
    await saveToFile(filePath, project);
    return filePath;
  }
}
