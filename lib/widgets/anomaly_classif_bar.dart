import 'package:flutter/material.dart';
import 'package:skavl/theme/colors.dart';
import 'package:skavl/l10n/app_localizations.dart';
import 'package:skavl/widgets/dialogs/confirm_anomaly_popup.dart';

class AnomalyClassifBar extends StatefulWidget {
  const AnomalyClassifBar({super.key});

  @override
  State<AnomalyClassifBar> createState() => _AnomalyClassifBar();
}

class _AnomalyClassifBar extends State<AnomalyClassifBar> {

  AppLocalizations? loc() {
    return AppLocalizations.of(context);
  }

  double _currentSliderValue = 0.5;
  late TextEditingController _textController;

  int _currentImage = 1;
  final int _totalImages = 789;

  // open confirm anomaly dialog and wait for result
  Future<void> openAnomalyConfirmDialog() async {
        // Show loading dialog
    ConfirmAnomalyDialog.show(context);

    // Simulate async work
    if (!mounted) return;
  }    

  @override
  void initState() {
    super.initState();
    _textController = TextEditingController(
      text: _currentSliderValue.toStringAsFixed(3),
    );
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  void _arrowBackPressed() {
    setState(() {
      if (_currentImage > 1) {
        _currentImage--;
      } else {
        _currentImage = _totalImages;
      }
    });
  }

    void _arrowForwardPressed() {
    setState(() {
      if (_currentImage < _totalImages) {
        _currentImage++;
      } else {
        _currentImage = 1;
      }
    });
  }

  void _updateFromText(String value) {
    final parsed = double.tryParse(value);
    if (parsed != null && parsed >= 0 && parsed <= 1) {
      setState(() {
        _currentSliderValue = parsed;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
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
                      _textController.text = value.toStringAsFixed(3);
                    });
                  },
                ),
              ),
              
              const SizedBox(width: 12),
              
              // Text input for anomaly classification threshold
              SizedBox(
                width: 80,
                child: TextField(
                  controller: _textController,
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: true,
                  ),
                  onChanged: _updateFromText,
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
                onPressed: _arrowBackPressed,
                child: Icon(
                    Icons.arrow_back,
                    size: 20,
                    color: Theme.of(context).brightness == Brightness.light
                        ? MyColors.secondaryBlack
                        : MyColors.primaryWhite,
                  ),
              ),
              
              SizedBox(width: 20),

              SizedBox(
                width: 150,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(color: Theme.of(context).brightness == Brightness.light
                            ? MyColors.secondaryBlack
                            : MyColors.primaryWhite, width: 1),
                  ),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: Text(
                        '$_currentImage / $_totalImages',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ),
                  ),
                )
              ),

              SizedBox(width: 20),

              ElevatedButton(
                onPressed: _arrowForwardPressed,
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
