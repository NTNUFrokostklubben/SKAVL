import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skavl/l10n/app_localizations.dart';
import 'package:skavl/services/anomaly_service_provider.dart';
import 'package:skavl/theme/colors.dart';
import 'package:skavl/widgets/labels/headings.dart';
import 'package:skavl/widgets/top_bar.dart';
import 'package:skavl/widgets/upload.dart';
import 'package:skavl/widgets/dialogs/loading_popup.dart';

class CreateNewReportPage extends StatefulWidget {
  const CreateNewReportPage({super.key});

  @override
  State<CreateNewReportPage> createState() => _CreateNewReportPageState();
}

class _CreateNewReportPageState extends State<CreateNewReportPage> {
  AppLocalizations? loc() {
    return AppLocalizations.of(context);
  }

  late TextEditingController _titleController;
  String? _imageFolderPath;
  String? _sosiFilePath;

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

  //
  Future<void> startLoadingModal() async {
    // Show loading dialog
    LoadingDialog.show(context);

    // Simulate async work
    await Future.delayed(const Duration(seconds: 10));
    if (!mounted) return;

    // Hide dialog
    LoadingDialog.hide(context);
  }

  // Temporary method for testing anomaly detection start based on selected params
  Future<void> _startAnomalyDetection() async {
    final imagePath = _imageFolderPath;
    final sosiPath = _sosiFilePath;

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
    context.read<AnomalyServiceProvider>().controller.getProjectInfo(
      projectName: _titleController.text,
      imagePath: imagePath,
      sosiPath: sosiPath,
    );

    context.read<AnomalyServiceProvider>().controller.runAnalysis(
      projectName: _titleController.text,
      imagePath: imagePath,
      sosiPath: sosiPath,
    );
  }

  // Method for picking an image folder
  Future<void> _pickImageFolder() async {
    final path = await FilePicker.getDirectoryPath();
    if (path != null) {
      setState(() => _imageFolderPath = path);
    }
  }

  // Method for picking SOSI file, needs to be refactored to set param so it can be reused for water mask sosi.
  Future<void> _pickSosiFile() async {
    final result = await FilePicker.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['sos'],
    );
    if (result != null) {
      setState(() => _sosiFilePath = result.files.single.path);
    }
  }

  @override
  Widget build(BuildContext context) {
    final containerWidth = MediaQuery.of(context).size.width * 0.9;
    final titleStart =
        (MediaQuery.of(context).size.width - containerWidth) * 0.5;
    final containerHeight = MediaQuery.of(context).size.height * 0.8;

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: 40),
            Align(
              alignment: Alignment.centerLeft,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(width: titleStart),
                  LargeHeader(loc()!.createPage_title),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                width: containerWidth,
                height: containerHeight,
                alignment: Alignment.topLeft,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        controller: _titleController,
                        decoration: InputDecoration(
                          labelText: loc()!.createPage_titleInput,
                        ),
                      ),
                    ),

                    // Upload boxes
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          UploadBox(
                            text:
                                _imageFolderPath ??
                                loc()!.createPage_uploadPlaneImages,
                            onTap: _pickImageFolder,
                            width: containerWidth * 0.5 - 20,
                          ),
                          UploadBox(
                            text:
                                _sosiFilePath ??
                                loc()!.createPage_uploadSOSIFile,
                            onTap: _pickSosiFile,
                            width: containerWidth * 0.5 - 20,
                          ),
                        ],
                      ),
                    ),

                    Spacer(),

                    // Create report button
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          ElevatedButton(
                            onPressed: startLoadingModal,
                            child: Row(
                              spacing: 8,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  loc()!.createPage_createReportButton,
                                  style: Theme
                                      .of(context)
                                      .textTheme
                                      .bodyMedium,
                                ),
                                Icon(
                                  Icons.arrow_forward_ios_outlined,
                                  size: 20,
                                  color:
                                  Theme
                                      .of(context)
                                      .brightness ==
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
          ],
        ),
      ),
      appBar: TopBar(foreignContext: context),
    );
  }
}
