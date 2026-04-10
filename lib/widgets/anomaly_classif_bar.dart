import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skavl/theme/colors.dart';
import 'package:skavl/l10n/app_localizations.dart';
import 'package:skavl/widgets/dialogs/confirm_anomaly_popup.dart';

import '../services/project_file_service.dart';
import '../services/project_manager_service.dart';

class AnomalyClassifBar extends StatefulWidget {
  const AnomalyClassifBar({super.key});

  @override
  State<AnomalyClassifBar> createState() => _AnomalyClassifBar();
}

class _AnomalyClassifBar extends State<AnomalyClassifBar> {


  AppLocalizations? loc() {
    return AppLocalizations.of(context);
  }

  late double _currentSliderValue;
  late TextEditingController _sensitivityController;
  late TextEditingController _imageController;
  int _currentImage = 1;

  @override
  void initState() {
    super.initState();
    final projectManager = context.read<ProjectManagerService>();
    _currentSliderValue = projectManager.loadedProject?.sensitivity ?? 0.5;
    _sensitivityController = TextEditingController(
      text: _currentSliderValue.toStringAsFixed(3),
    );
    _imageController = TextEditingController(text: _currentImage.toString());
  }

  @override
  void dispose() {
    _sensitivityController.dispose();
    _imageController.dispose();
    super.dispose();
  }

  Future<void> _saveSensitivity(double value) async {
    final projectManager = context.read<ProjectManagerService>();
    final project = projectManager.loadedProject;
    final filePath = projectManager.filePath;
    if (project == null || filePath == null) return;
    final updated = project.copyWith(sensitivity: value);
    projectManager.setProject(updated, filePath);
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

  Future<void> openAnomalyConfirmDialog() async {
    ConfirmAnomalyDialog.show(context);
    if (!mounted) return;
  }

  void _arrowBackPressed(int totalImages) {
    setState(() {
      if (_currentImage > 1) {
        _currentImage--;
      } else {
        _currentImage = totalImages;
      }
      _imageController.text = _currentImage.toString();
    });
  }

  void _arrowForwardPressed(int totalImages) {
    setState(() {
      if (_currentImage < totalImages) {
        _currentImage++;
      } else {
        _currentImage = 1;
      }
      _imageController.text = _currentImage.toString();
    });
  }

  void _updateImageFromText(String value, int totalImages) {
    final parsed = int.tryParse(value);

    if (parsed != null && parsed >= 1 && parsed <= totalImages) {
      setState(() {
        _currentImage = parsed;
        _imageController.text = _currentImage.toString();
      });
    } else {
      _imageController.text = _currentImage.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    final projectManager = context.watch<ProjectManagerService>();
    final totalImages = projectManager.loadedProject?.anomaliesInRange.length ?? 0;
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
        
        // Confirm annomaly classification button
        Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  onPressed: openAnomalyConfirmDialog,
                  child: Row(
                    spacing: 8,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        loc()!.anomalyClassifBar_confirm,
                        style: Theme.of(context).textTheme.bodyMedium,
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),

        SizedBox(width: 50),

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
          )
        ],
      ),
    );
  }
}
