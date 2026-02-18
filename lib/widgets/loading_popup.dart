import 'dart:async';
import 'package:flutter/material.dart';
import 'package:skavl/l10n/app_localizations.dart';

class LoadingDialog extends StatefulWidget {
  const LoadingDialog({super.key});

  @override
  State<LoadingDialog> createState() => _LoadingDialogState();

  static void show(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => LoadingDialog(),
    );
  }

  static void hide(BuildContext context) {
    Navigator.of(context, rootNavigator: true).pop();
  }
}

class _LoadingDialogState extends State<LoadingDialog> {

  AppLocalizations? loc() {
    return AppLocalizations.of(context);
  }

  // TODO: This is just a mockup, replace with real progress updates

  double totalImages = 17000;
  double progress = 0.0;
  Timer? _timer;
  

  @override
  void initState() {
    super.initState();
    _startLoading();
  }

  void _startLoading() {
    _timer = Timer.periodic(const Duration(milliseconds: 100), (timer) {
      setState(() {
        progress += 0.01; // 10%

        if (progress >= 1.0) {
          progress = 1.0;
          _timer?.cancel();
        }
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
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
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      loc()!.loadingDialog_analyzing,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      loc()!.loadingDialog_grabCoffee,
                    ),
                    const SizedBox(height: 30),
                    LinearProgressIndicator(
                      value: progress,
                      semanticsLabel: loc()!.loadingDialog_semanticsLabel,
                      borderRadius: BorderRadius.circular(2),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      '${(totalImages*progress).toInt()} / ${totalImages.toInt()}',
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
  }
}