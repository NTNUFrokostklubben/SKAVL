import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';
import 'package:skavl/controller/anomaly_detector_controller.dart';
import 'package:skavl/l10n/app_localizations.dart';
import 'package:skavl/proto/anomaly.pb.dart';
import 'package:skavl/services/anomaly_service_provider.dart';
import 'package:skavl/services/project_manager_service.dart';
import 'package:skavl/widgets/long_button.dart';

import '../../entity/analysis_progress.dart';

class LoadingDialog extends StatelessWidget {
  final ValueNotifier<AnalysisProgress> progress;

  const LoadingDialog({super.key, required this.progress});

  static void show(
    BuildContext context, {
    required ValueNotifier<AnalysisProgress> progress,
  }) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => LoadingDialog(progress: progress),
    );
  }

  Future<void> _stopAnalysis(BuildContext context) async {
    final ProjectManagerService pm = context.read<ProjectManagerService>();
    final AnomalyDetectorController controller = context
        .read<AnomalyServiceProvider>()
        .controller;

    controller.anomalyDetectorClient
        .stopAnalysis(
          StopAnalysisRequest(projectName: pm.loadedProject!.projectName),
        )
        .then((response) {
          if (response.acknowledged) {
            controller.stopPolling();
            progress.value = AnalysisProgress(
              progress.value.processed,
              progress.value.total,
              isStopping: true,
            );
          }
        });
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
                        processed.isStopping
                            ? loc!.loadingDialog_stopping
                            : loc!.loadingDialog_analyzing,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(loc.loadingDialog_grabCoffee),
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
                },
              ),
            ),
            LongButton(
              loc!.loadingDialog_stop,
              onPressed: () {
                _stopAnalysis(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
