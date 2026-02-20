import 'package:flutter/material.dart';
import 'package:skavl/theme/colors.dart';
import 'package:skavl/l10n/app_localizations.dart';

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
      color: MyColors.grey,
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
                  cursorColor: MyColors.secondaryBlack,
                  decoration: InputDecoration(
                    isDense: true,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 8,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(4),
                    ),
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
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  onPressed: () {},
                  child: Row(
                    spacing: 8,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        loc()!.anomalyClassifBar_confirm,
                        style: const TextStyle(
                          fontSize: 16,
                          color: MyColors.secondaryBlack,
                        ),
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
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(2),
                  ),
                  backgroundColor: MyColors.grey,
                ),
                onPressed: _arrowBackPressed,
                child: Icon(
                    Icons.arrow_back,
                    size: 20,
                    color: MyColors.secondaryBlack,
                  ),
              ),
              
              SizedBox(width: 20),

              SizedBox(
                width: 150,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(2),
                    border: Border.all(color: MyColors.secondaryBlack, width: 1),
                  ),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: Text(
                        '$_currentImage / $_totalImages',
                        style: const TextStyle(
                          fontSize: 16,
                          color: MyColors.secondaryBlack,
                        ),
                      ),
                    ),
                  ),
                )
              ),

              SizedBox(width: 20),

              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(2),
                  ),
                  backgroundColor: MyColors.grey,
                ),
                onPressed: _arrowForwardPressed,
                child: Icon(
                  Icons.arrow_forward,
                  size: 20,
                  color: MyColors.secondaryBlack,
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
