import 'package:flutter/material.dart';
import 'package:skavl/l10n/app_localizations.dart';

import '../../entity/analysis_progress.dart';

class LoadingDialog extends StatelessWidget {
  final ValueNotifier<AnalysisProgress> progress;

  const LoadingDialog({
    super.key,
    required this.progress
  });

  static void show(BuildContext context, {
    required ValueNotifier<AnalysisProgress> progress
  }) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => LoadingDialog(
        progress: progress,
      ),
    );
  }

  static void hide(BuildContext context) {
    Navigator.of(context, rootNavigator: true).pop();
  }

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
                child: ValueListenableBuilder<AnalysisProgress>(
                  valueListenable: progress,
                  builder: (_, processed, _) {
                    final total = progress.value.total;
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
                          loc.loadingDialog_grabCoffee,
                        ),
                        const SizedBox(height: 30),
                        LinearProgressIndicator(
                          value: total > 0 ? processed.processed / total : null,
                          semanticsLabel: loc.loadingDialog_semanticsLabel,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          '${processed.processed} / $total',
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