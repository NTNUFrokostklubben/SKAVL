import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skavl/entity/project_metadata.dart';
import 'package:skavl/theme/colors.dart';
import 'package:skavl/l10n/app_localizations.dart';
import 'package:skavl/widgets/dialogs/confirm_anomaly_popup.dart';

import '../entity/anomaly_def.dart';
import '../entity/anomaly_set.dart';
import '../services/project_file_service.dart';
import '../services/project_manager_service.dart';

class AnomalyClassifBar extends StatefulWidget {
  const AnomalyClassifBar({super.key});

  @override
  State<AnomalyClassifBar> createState() => _AnomalyClassifBar();
}

class _AnomalyClassifBar extends State<AnomalyClassifBar> {

  ProjectManagerService? _projectManager;

  AppLocalizations? loc() {
    return AppLocalizations.of(context);
  }

  late double _currentSliderValue;
  late TextEditingController _sensitivityController;
  late TextEditingController _imageController;

  @override
  void initState() {
    super.initState();
    final projectManager = context.read<ProjectManagerService>();
    _currentSliderValue = projectManager.loadedProject?.sensitivity ?? 0.5;
    _sensitivityController = TextEditingController(
      text: _currentSliderValue.toStringAsFixed(3),
    );
    final initialPage = projectManager.loadedProject?.currentPage ?? 0;
    _imageController = TextEditingController(text: (initialPage + 1).toString());
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final pm = context.read<ProjectManagerService>();
    if (pm != _projectManager) {
      _projectManager?.removeListener(_onProviderChanged);
      _projectManager = pm;
      _projectManager!.addListener(_onProviderChanged);
      _syncFromProvider();
    }
  }

  /// Syncs current page with project that's loaded.
  ///
  /// Needed for sensitivity and page changes
  void _syncFromProvider() {
    final project = _projectManager?.loadedProject;
    final sensitivity = project?.sensitivity ?? 0.5;
    final page = project?.currentPage ?? 0;

    if (_currentSliderValue != sensitivity) {
      _currentSliderValue = sensitivity;
      _sensitivityController.text = sensitivity.toStringAsFixed(3);
    }
    final pageText = (page + 1).toString();
    if (_imageController.text != pageText) {
      _imageController.text = pageText;
    }
  }

  void _onProviderChanged() {
    if (mounted) {
      _syncFromProvider();
      setState(() {});
    }
  }

  @override
  void dispose() {
    _projectManager?.removeListener(_onProviderChanged);
    _sensitivityController.dispose();
    _imageController.dispose();
    super.dispose();
  }

  /// Saves sensitivity from slider to the project.
  Future<void> _saveSensitivity(double value) async {
    final project = _projectManager?.loadedProject;
    final filePath = _projectManager?.filePath;
    if (project == null || filePath == null) return;

    // Clamp currentPage to new range so it stays valid after sensitivity change
    final newRange = project.allSets.where((s) => s.anomalyConf >= value).toList();
    final newPage = newRange.isEmpty ? 0 : project.currentPage.clamp(0, newRange.length - 1);

    final updated = project.copyWith(sensitivity: value, currentPage: newPage);
    _projectManager?.setProject(updated, filePath);
    await ProjectFileService().saveToFile(filePath, updated);
  }

  void _updateSensitivityFromText(String value) {
    final parsed = double.tryParse(value);
    if (parsed != null && parsed >= 0 && parsed <= 1) {
      setState(() {
        _currentSliderValue = parsed;
        _sensitivityController.text = parsed.toStringAsFixed(3);
      });
      _saveSensitivity(parsed);
    } else {
      _sensitivityController.text = _currentSliderValue.toStringAsFixed(3);
    }
  }

  /// Saves to the project file what page is currently being processed.
  ///
  /// Used for when you leave the page and come back as well as for retentive navigation.
  Future<void> _savePage(int zeroIndexedPage) async {
    final project = _projectManager?.loadedProject;
    final filePath = _projectManager?.filePath;
    if (project == null || filePath == null) return;
    final updated = project.copyWith(currentPage: zeroIndexedPage);
    _projectManager?.setProject(updated, filePath);
    await ProjectFileService().saveToFile(filePath, updated);
  }

  Future<void> openAnomalyConfirmDialog() async {
    final result = await ConfirmAnomalyDialog.show(context);
    if (!mounted || result == null) return;

    final ProjectMetadata project = _projectManager!.loadedProject!;
    final String filePath = _projectManager!.filePath!;
    final AnomalySet current = project.anomaliesInRange[project.currentPage];

    final int index = project.allSets.indexWhere(
      (s) => s.imageName == current.imageName,
    );
    if (index == -1) return;

    final updatedSets = List<AnomalySet>.from(project.allSets);

    updatedSets[index] = updatedSets[index].copyWith(
      anomalyDef: result.anomalyDef,
      userClassification: result.userClassification,
      clearUserClassification: result.anomalyDef == AnomalyDef.noAnomaly,
    );

    final ProjectMetadata updated = project.copyWith(allSets: updatedSets);
    _projectManager!.setProject(updated, filePath);
    await ProjectFileService().saveToFile(filePath, updated);
  }

  void _arrowBackPressed(int totalImages) {
    final currentPage = _projectManager?.loadedProject?.currentPage ?? 0;
    final newPage = currentPage > 0 ? currentPage - 1 : totalImages - 1;
    _savePage(newPage);
  }

  void _arrowForwardPressed(int totalImages) {
    final currentPage = _projectManager?.loadedProject?.currentPage ?? 0;
    final newPage = currentPage < totalImages - 1 ? currentPage + 1 : 0;
    _savePage(newPage);
  }

  void _updateImageFromText(String value, int totalImages) {
    final parsed = int.tryParse(value);
    if (parsed != null && parsed >= 1 && parsed <= totalImages) {
      _savePage(parsed - 1); // display is 1-indexed, storage is 0-indexed
    } else {
      final currentPage = _projectManager?.loadedProject?.currentPage ?? 0;
      _imageController.text = (currentPage + 1).toString();
    }
  }


  @override
  Widget build(BuildContext context) {
    final totalImages = _projectManager?.loadedProject?.anomaliesInRange.length ?? 0;

    final current = totalImages > 0
        ? _projectManager!.loadedProject!.anomaliesInRange[_projectManager!.loadedProject!.currentPage]
        : null;
    final statusText = switch (current?.anomalyDef) {
      AnomalyDef.anomaly => loc()!.anomalyClassifBar_anomaly,
      AnomalyDef.noAnomaly => loc()!.anomalyClassifBar_noAnomaly,
      _ => loc()!.anomalyClassifBar_unClassified,
    };
    return BottomAppBar(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          // Slider for anomaly classification threshold
          Row(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.3,
                child: Slider(
                  value: _currentSliderValue,
                  min: 0,
                  max: 1,
                  divisions: 1000,
                  onChanged: (double value) {
                    setState(() {
                      _currentSliderValue = value;
                      _sensitivityController.text = value.toStringAsFixed(3);
                    });
                  },
                  onChangeEnd: _saveSensitivity,
                ),
              ),

              const SizedBox(width: 12),

              // Text input for anomaly classification threshold
              SizedBox(
                width: 80,
                child: TextField(
                  controller: _sensitivityController,
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: true,
                  ),
                  onSubmitted: _updateSensitivityFromText,
                ),
              ),
            ],
          ),

          SizedBox(width: 50),

          // Confirm anomaly classification button
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ElevatedButton(
                  onPressed: openAnomalyConfirmDialog,
                  child: Text(
                    loc()!.anomalyClassifBar_confirm,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
                Text(statusText, style: Theme.of(context).textTheme.bodySmall),
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                ElevatedButton(
                  onPressed: () => _arrowBackPressed(totalImages),
                  child: Icon(
                    Icons.arrow_back,
                    size: 20,
                    color: Theme.of(context).brightness == Brightness.light
                        ? MyColors.secondaryBlack
                        : MyColors.primaryWhite,
                  ),
                ),

                SizedBox(width: 20),

                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(
                      color: Theme.of(context).brightness == Brightness.light
                          ? MyColors.secondaryBlack
                          : MyColors.primaryWhite,
                      width: 1,
                    ),
                  ),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 60,
                        child: TextField(
                          controller: _imageController,
                          keyboardType: TextInputType.number,
                          textAlign: TextAlign.center,
                          onSubmitted: (v) => _updateImageFromText(v, totalImages),
                          decoration: const InputDecoration(
                            filled: false,
                            isDense: true,
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 0,
                              vertical: 0,
                            ),
                          ),
                        ),
                      ),
                      Text(" / $totalImages"),
                    ],
                  ),
                ),

                SizedBox(width: 20),

                ElevatedButton(
                  onPressed: () => _arrowForwardPressed(totalImages),
                  child: Icon(
                    Icons.arrow_forward,
                    size: 20,
                    color: Theme.of(context).brightness == Brightness.light
                        ? MyColors.secondaryBlack
                        : MyColors.primaryWhite,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
