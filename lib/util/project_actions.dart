import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:skavl/main.dart';
import 'package:skavl/util/navigation_util.dart';

import '../services/project_file_service.dart';
import '../services/project_manager_service.dart';

/// Class to provide static methods for saving, loading and creating projects
///
/// Methods here handle the "UI" part of projects such as opening file pickers etc.
/// See [ProjectFileService] for the actual file operations.
class ProjectActions {

  /// Opens a project from file and sets the context
  static Future<void> openProject(BuildContext context) async {

    final projectState = context.read<ProjectManagerService>();

    final loadedFile = await FilePicker.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['skavl'],
    );
    if (loadedFile == null) return;

    final filepath = loadedFile.files.single.path;
    if (filepath == null) return;

    final project = await ProjectFileService().loadFromFile(filepath);
    projectState.setProject(project, filepath);
  }

  /// Saves current project to specified file
  static Future<void> saveAs(BuildContext context) async {
    final projectState = context.read<ProjectManagerService>();
    if (!projectState.hasProject) return;

    final savePath = await FilePicker.saveFile(
      dialogTitle: 'Save project',
      fileName: '${projectState.loadedProject?.projectName}.skavl',
      type: FileType.custom,
      allowedExtensions: ['skavl'],
    );
    if (savePath == null) return;

    final currentProject = projectState.loadedProject;
    if (currentProject == null) return;

    await ProjectFileService().saveToFile(savePath, currentProject);

    final project = await ProjectFileService().loadFromFile(savePath);
    projectState.setProject(project, savePath);
  }

  /// Saves current project to current file
  static Future<void> saveProject(BuildContext context) async {
    final projectState = context.read<ProjectManagerService>();
    if (!projectState.hasProject) return;

    final currentProject = projectState.loadedProject;
    if (currentProject == null) return;

    final projectPath = projectState.filePath;
    if (projectPath == null) return;

    await ProjectFileService().saveToFile(projectPath, currentProject);
  }

  /// Closes current project and navigates back to the home page
  ///
  /// Might have to implement some check for stopping current analysis before closing
  static Future<void> closeProject(BuildContext context) async {
    final projectState = context.read<ProjectManagerService>();
    if (!projectState.hasProject) return;

    projectState.clearProject();
    navigateTo(context, MainPage());
  }
}