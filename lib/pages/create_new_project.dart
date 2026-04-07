import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skavl/l10n/app_localizations.dart';
import 'package:skavl/services/anomaly_service_provider.dart';
import 'package:skavl/services/project_manager_service.dart';
import 'package:skavl/theme/colors.dart';
import 'package:skavl/widgets/bottom_status_bar.dart';
import 'package:skavl/widgets/labels/headings.dart';
import 'package:skavl/widgets/top_bar.dart';
import 'package:skavl/widgets/upload.dart';
import 'package:skavl/widgets/dialogs/loading_popup.dart';

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
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Missing project name")));
      return;
    }
    if (imagePath == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Missing image folder path")));
      return;
    }
    if (sosiPath == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Missing SOSI file")));
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
  }

  // Method for picking an image folder
  Future<void> _pickImageFolder() async {
    final path = await FilePicker.getDirectoryPath();
    if (path != null) {
      setState(() => _imageFolderPath = path);
    }
  }

  // Method for picking SOSI file, needs to be refactored to set param so it can be reused for water mask sosi.
  Future<String?> _pickSosiFile() async {
    final result = await FilePicker.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['sos'],
    );
    if (result != null) {
      return result.files.single.path;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final containerWidth = MediaQuery.of(context).size.width * 0.9;

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 40),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: LargeHeader(loc()!.newprojectPage_title),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  alignment: Alignment.topLeft,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      TextField(
                        controller: _titleController,
                        decoration: InputDecoration(
                          labelText: loc()!.createPage_titleInput,
                        ),
                      ),

                      // Upload boxes
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: UploadBox(
                              text:
                                  _imageFolderPath ??
                                  loc()!.createPage_uploadPlaneImages,
                              onTap: _pickImageFolder,
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: UploadBox(
                                text:
                                    _sosiFilePath ??
                                    loc()!.createPage_uploadSOSIFile,
                                onTap: () async {
                                  final path = await _pickSosiFile();
                                  if (path != null) {
                                    setState(() {
                                      _sosiFilePath = path;
                                    });
                                  }
                                },
                              ),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: UploadBox(
                                text:
                                    _sosiWaterFilePath ??
                                    loc()!.createPage_uploadSOSIFile,
                                onTap: () async {
                                  final path = await _pickSosiFile();
                                  if (path != null) {
                                    setState(() {
                                      _sosiWaterFilePath = path;
                                    });
                                  }
                                },
                              ),
                            ),
                          ),
                        ],
                      ),

                      Spacer(),

                      // Create report button
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            ElevatedButton(
                              onPressed: _createProject,
                              child: Row(
                                spacing: 8,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    loc()!.createPage_createReportButton,
                                    style: Theme.of(
                                      context,
                                    ).textTheme.bodyMedium,
                                  ),
                                  Icon(
                                    Icons.arrow_forward_ios_outlined,
                                    size: 20,
                                    color:
                                        Theme.of(context).brightness ==
                                            Brightness.light
                                        ? MyColors.secondaryBlack
                                        : MyColors.primaryWhite,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      appBar: TopBar(foreignContext: context),
      bottomNavigationBar: BottomStatusBar(foreignContext: context),
    );
  }
}
