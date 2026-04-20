import 'dart:async';
import 'package:flutter/material.dart';
import 'package:skavl/l10n/app_localizations.dart';

class LoadingDialog extends StatelessWidget {
  final ValueNotifier<int> processedImages;
  final ValueNotifier<int> totalImages;

  const LoadingDialog({
    super.key,
    required this.processedImages,
    required this.totalImages,
  });

  static void show(BuildContext context, {
    required ValueNotifier<int> processedImages,
    required ValueNotifier<int> totalImages,
  }) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => LoadingDialog(
        processedImages: processedImages,
        totalImages: totalImages,
      ),
    );
  }

  static void hide(BuildContext context) {
    Navigator.of(context, rootNavigator: true).pop();
  }

  // TODO: This is just a mockup, replace with real progress updates

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    return AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
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
                child: ValueListenableBuilder<int>(
                  valueListenable: processedImages,
                  builder: (_, processed, _) {
                    final total = totalImages.value;
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          loc!.loadingDialog_analyzing,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          loc!.loadingDialog_grabCoffee,
                        ),
                        const SizedBox(height: 30),
                        LinearProgressIndicator(
                          value: total > 0 ? processed / total : null,
                          semanticsLabel: loc.loadingDialog_semanticsLabel,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          '$processed / $total',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ],
                    );
                  }
                ),
              ),
            ],
          ),
        ),
      );
  }
}