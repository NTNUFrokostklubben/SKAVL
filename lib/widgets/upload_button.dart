import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:skavl/widgets/labels/fieldlabels.dart';

import '../l10n/app_localizations.dart';

/// Widget to select a file or folder location for use in the application
class UploadButton extends StatelessWidget {
  const UploadButton({
    super.key,
    required this.label,
    this.isRequired = false,
    this.isFolder = false,
    this.selectedPath,
    required this.onPathSelected,
  });

  final String label;
  final bool isRequired;
  final bool isFolder;
  final String? selectedPath;
  final ValueChanged<String> onPathSelected;


  Future<void> _pickPath(BuildContext context) async {
    String? result;

    if (isFolder) {
      result = await FilePicker.getDirectoryPath();
    } else {
      final pickedFile = await FilePicker.pickFiles(
        type: FileType.custom,
        allowedExtensions: ["sos"],
      );
      if (pickedFile != null) {
        result = pickedFile.files.single.path;
      }
    }

    if (result != null) {
      onPathSelected(result);
    }
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 10.0,
        children: [
          Row(
            spacing: 8.0,
            children: [
              LargeLabel(label),
              if (isRequired) Text("*", style: TextStyle(color: Colors.red)),
            ],
          ),
          Row(
            spacing: 10.0,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ElevatedButton(
                onPressed: () => _pickPath(context),
                child: Text(loc!.g_browse),
              ),
              if (isFolder)
                Text(selectedPath != null ? selectedPath! : loc.createPage_noFolder)
              else
                Text(selectedPath != null ? selectedPath! : loc.createPage_noFile)
            ],
          ),
        ],
      ),
    );
  }
}
