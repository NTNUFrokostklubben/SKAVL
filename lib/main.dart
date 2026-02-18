import 'package:flutter/material.dart';
import 'package:skavl/model/settings_model.dart';
import 'package:skavl/theme/app_themes.dart';
import 'package:skavl/widgets/top_bar.dart';
import 'l10n/app_localizations.dart';
import 'package:skavl/widgets/long_button.dart';
import 'package:provider/provider.dart';
import 'package:skavl/widgets/anomaly_classif_bar.dart';

void main() {
  runApp(
    /// State system for settings
    ChangeNotifierProvider(
      create: (_) => SettingsModel(),
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
                    Text(
                      loc()!.welcomePage_SKAVL,
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    LongButton(loc()!.welcomePage_openFormer),
                    LongButton(loc()!.welcomePage_createNewButton),
                  ],
                ),
                const Image(
                  image: AssetImage('assets/images/topographic-icon.png'),
                  width: 200,
                ),
              ]
            )
          ],
        ),
      ),
      bottomNavigationBar: AnomalyClassifBar(), 
    );
  }
}
