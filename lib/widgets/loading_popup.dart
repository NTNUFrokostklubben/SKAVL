import 'package:flutter/material.dart';

class LoadingDialog {
  /// Show loading dialog
  static void show(BuildContext context, {String text = "Loading..."}) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => AlertDialog(
        content: SizedBox(
          width: 800,
          height: 400,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 50),
              SizedBox(
                width: 100,
                height: 100,
                child: Transform.scale(
                    scale: 1.0,
                    child: CircularProgressIndicator(),
                  ),
              ),
              const SizedBox(height: 50),
              Expanded(child: Text(text)),
            ],
          ),
        ),
      ),
    );
  }

  /// Hide loading dialog
  static void hide(BuildContext context) {
    Navigator.of(context, rootNavigator: true).pop();
  }
}
