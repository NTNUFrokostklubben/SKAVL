import 'dart:io';

import 'package:flutter/material.dart';
import 'package:grpc/grpc.dart';
import 'package:skavl/model/settings_model.dart';
import 'package:skavl/proto/anomaly.pbgrpc.dart';
import 'package:skavl/services/anomaly_service_provider.dart';
import 'package:skavl/services/project_manager_service.dart';
import 'package:skavl/services/service_manager.dart';
import 'package:skavl/theme/app_themes.dart';
import 'package:skavl/widgets/anomaly_classif_bar.dart';
import 'package:skavl/widgets/top_bar.dart';
import 'l10n/app_localizations.dart';
import 'package:skavl/widgets/long_button.dart';
import 'package:provider/provider.dart';
import 'package:skavl/widgets/labels/headings.dart';

void main() {
  runApp(
    /// State system for settings
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => SettingsModel()),
        ChangeNotifierProvider(create: (_) => ProjectManagerService()),
        ChangeNotifierProvider(create: (_) => AnomalyServiceProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final settings = context.watch<SettingsModel>();

    return MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: settings.locale,
      title: 'SKAVL',

      theme: AppThemes.lightTheme,
      darkTheme: AppThemes.darkTheme,
      themeMode: settings.theme,
      home: const MainPage(),
    );
  }
}

/// Abstracted MainPage into an "Orchestrator"
class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  late final ServiceManager _tilerService;

  @override
  void initState() {
    super.initState();

    // Determine tiler service path based on OS.
    _tilerService = ServiceManager(
      Platform.isWindows
          ? 'services/tiler/server/skavl-tiler.exe'
          : 'services/tiler/server/skavl-tiler',
    );

    // Callback to check if the service executable is missing. Will be implemented more cleanly in the future, but for debugging and MVP this is sufficient.
    _tilerService.statusStream.listen((status) {
      if (status == ServiceStatus.notFound) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Tiler service executable not found.'),
                duration: Duration(seconds: 5),
              ),
            );
          }
        });
      }
    });

    _tilerService.start();
  }

  @override
  void dispose() {
    _tilerService.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MyHomePage(title: "title");
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late final ClientChannel channel;
  late final AnomalyDetectorServiceClient anomalyClient;

  AppLocalizations? loc() {
    return AppLocalizations.of(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopBar(foreignContext: context),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  spacing: 20,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    LargeHeader(loc()!.welcomePage_SKAVL),
                    LongButton(loc()!.welcomePage_openFormer),
                    LongButton(loc()!.welcomePage_createNewButton),
                  ],
                ),
                const Image(
                  image: AssetImage('assets/images/topographic-icon.png'),
                  width: 200,
                ),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: AnomalyClassifBar(),
    );
  }
}
