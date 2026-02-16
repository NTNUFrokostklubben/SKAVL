import 'package:flutter/material.dart';
import 'package:skavl/theme/colors.dart';


class LongButton extends StatelessWidget {
  const LongButton(this.title, {super.key});

  final String title;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 400,
      height: 50,
      child: ElevatedButton(
        onPressed: () {
          print("Button pressed!");
        },
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(2)),
        ),
        child: Text(this.title, 
          style: const TextStyle(fontSize: 16, color: MyColors.secondaryBlack)),
      ),
    );
  }
}
