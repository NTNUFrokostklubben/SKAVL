import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skavl/l10n/app_localizations.dart';
import 'package:skavl/main.dart';
import 'package:skavl/services/project_manager_service.dart';
import 'package:skavl/theme/colors.dart';
import 'package:skavl/util/navigation_util.dart';
import 'package:skavl/widgets/bottom_status_bar.dart';
import 'package:skavl/widgets/labels/headings.dart';
import 'package:skavl/widgets/top_bar.dart';
import 'package:skavl/widgets/upload_button.dart';

import '../entity/project_metadata.dart';
import '../services/project_file_service.dart';

class CreateNewProject extends StatefulWidget {
  const CreateNewProject({super.key});

  @override
  State<CreateNewProject> createState() => _CreateNewProjectState();
}

class _CreateNewProjectState extends State<CreateNewProject> {
  AppLocalizations? loc() {
    return AppLocalizations.of(context);
  }

  late TextEditingController _titleController;
  String? _imageFolderPath;
  String? _sosiFilePath;
  String? _sosiWaterFilePath;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController();
  }

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  Future<void> _createProject() async {
    final imagePath = _imageFolderPath;
    final sosiPath = _sosiFilePath;
    final sosiWaterPath = _sosiWaterFilePath;

    if (_titleController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(loc()!.newprojectPage_Missingproject)),
      );
      return;
    }
    if (imagePath == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(loc()!.newprojectPage_Missingaerial)),
      );
      return;
    }
    if (sosiPath == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(loc()!.newprojectPage_Missingsosi)),
      );
      return;
    }

    final savePath = await FilePicker.saveFile(
      dialogTitle: 'Save project',
      fileName: '${_titleController.text}.skavl',
      type: FileType.custom,
      allowedExtensions: ['skavl'],
    );

    if (savePath == null) return; // user cancelled

    final project = ProjectMetadata(
      projectName: _titleController.text,
      sosiFilePath: sosiPath,
      imageFolderPath: imagePath,
      sosiWaterMaskPath: sosiWaterPath,
    );

    await ProjectFileService().saveToFile(savePath, project);
    if (!mounted) return;

    context.read<ProjectManagerService>().setProject(project, savePath);
    navigateTo(context, MainPage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            LargeHeader(loc()!.newprojectPage_title),
            SizedBox(height: 32),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                spacing: 16,
                children: [
                  TextField(
                    controller: _titleController,
                    decoration: InputDecoration(
                      labelText: loc()!.createPage_titleInput,
                    ),
                  ),
                  SizedBox(height: 16),

                  // Upload boxes
                  UploadButton(
                    label: loc()!.createPage_uploadPlaneImages,
                    isRequired: true,
                    selectedPath: _imageFolderPath,
                    onPathSelected: (value) =>
                        setState(() => _imageFolderPath = value),
                    isFolder: true,
                  ),
                  UploadButton(
                    label: loc()!.createPage_uploadSOSIFile,
                    isRequired: true,
                    selectedPath: _sosiFilePath,
                    onPathSelected: (value) =>
                        setState(() => _sosiFilePath = value),
                  ),
                  UploadButton(
                    label: loc()!.createPage_uploadWaterSOSIFile,
                    selectedPath: _sosiWaterFilePath,
                    onPathSelected: (value) =>
                        setState(() => _sosiWaterFilePath = value),
                  ),

                  Spacer(),

                  // Create project button
                  Align(
                    alignment: Alignment.centerRight,
                    child: SizedBox(
                      height: 48,
                      child: ElevatedButton(
                        onPressed: _createProject,
                        child: Row(
                          spacing: 16,
                          mainAxisAlignment: MainAxisAlignment.end,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              loc()!.newprojectPage_title,
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                            Icon(
                              Icons.arrow_forward_ios_outlined,
                              size: 20,
                              color:
                                  Theme.of(context).brightness == Brightness.light
                                  ? MyColors.secondaryBlack
                                  : MyColors.primaryWhite,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: 8),
                ],
              ),
            ),
          ],
        ),
      ),
      appBar: TopBar(foreignContext: context),
      bottomNavigationBar: BottomStatusBar(),
    );
  }
}
