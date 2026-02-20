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
        },
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        ),
        child: Text(title, 
          style: const TextStyle(fontSize: 16, color: MyColors.secondaryBlack)),
      ),
    );
  }
}
