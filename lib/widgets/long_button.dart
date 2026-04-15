import 'package:flutter/material.dart';


class LongButton extends StatelessWidget {
  const LongButton(this.title, {super.key, this.onPressed});

  final String title;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 400,
      height: 50,
      child: ElevatedButton(
        onPressed: onPressed,
        child: Text(title, 
          style: Theme.of(context).textTheme.bodyMedium),
      ),
    );
  }
}
