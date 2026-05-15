import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:skavl/model/settings_model.dart';
import 'package:skavl/pages/create_new_project.dart';
import 'package:skavl/pages/project_overview.dart';
import 'package:skavl/services/anomaly_service_provider.dart';
import 'package:skavl/services/project_manager_service.dart';
import 'package:skavl/services/service_lifetime_service.dart';
import 'package:skavl/services/service_manager.dart';
import 'package:skavl/theme/app_themes.dart';
import 'package:skavl/util/navigation_util.dart';
import 'package:skavl/util/project_actions.dart';
import 'package:skavl/widgets/bottom_status_bar.dart';
import 'package:skavl/widgets/top_bar.dart';
import 'l10n/app_localizations.dart';
import 'package:skavl/widgets/long_button.dart';
import 'package:provider/provider.dart';
import 'package:skavl/widgets/labels/headings.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final settings = SettingsModel();
  await settings.load();

  runApp(
    /// State system for settings
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => settings),
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
      // Map system locales with fallbacks
      localeResolutionCallback: (deviceLocale, supported) {
        if (deviceLocale == null) return const Locale('nb');
        final lang = deviceLocale.languageCode;
        if (lang == 'nb' || lang == 'nn' || lang == 'no') {
          return const Locale('nb');
        }
        if (lang == 'en') return const Locale('en');
        return const Locale('nb');
      },
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

class _MainPageState extends State<MainPage> with WidgetsBindingObserver {
  StreamSubscription<ServiceStatusEvent>? _statusSub;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addObserver(this);

    _statusSub = ServiceLifetimeService().statusStream.listen((event) {
      if (event.status == ServiceStatus.notFound) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  'Service ${event.serviceName} executable not found.',
                ),
                duration: const Duration(seconds: 5),
              ),
            );
          }
        });
      }
    });

    ServiceLifetimeService().initAll();
  }

  @override
  Future<AppExitResponse> didRequestAppExit() async {
    await ServiceLifetimeService().shutdownAll();
    return AppExitResponse.exit;
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _statusSub?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final projectManager = context.watch<ProjectManagerService>();

    if (projectManager.loadedProject != null) {
      return ProjectOverview();
    }

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
                    LongButton(
                      loc()!.welcomePage_openFormer,
                      onPressed: () => ProjectActions.openProject(context),
                    ),
                    LongButton(
                      loc()!.welcomePage_createNewButton,
                      onPressed: () => navigateTo(context, CreateNewProject()),
                    ),
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
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [BottomStatusBar()],
      ),
    );
  }
}
