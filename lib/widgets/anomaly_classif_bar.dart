import 'package:flutter/material.dart';
import 'package:skavl/theme/colors.dart';

class AnomalyClassifBar extends StatefulWidget {
  const AnomalyClassifBar({super.key});

  @override
  State<AnomalyClassifBar> createState() => _AnomalyClassifBar();
}

class _AnomalyClassifBar extends State<AnomalyClassifBar> {
  double _currentSliderValue = 0.5;
  late TextEditingController _textController;

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
    );
  }
}
