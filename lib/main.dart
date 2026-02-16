import 'package:flutter/material.dart';
import 'l10n/app_localizations.dart';

import 'package:skavl/widgets/long_button.dart';
import 'package:skavl/theme/colors.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      title: 'SKAVL',

      theme: ThemeData(
        colorScheme: .fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'Welcome Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  /// Localization helper method to keep the build method clean
  /// This method retrieves the localized strings for the current context.
  /// It uses the AppLocalizations class to access the localized values.
  /// based on Applocalizations.of(context) but with a shorter name for convenience.
  AppLocalizations? loc() {
    return AppLocalizations.of(context);
  }
  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    const Text(
                      'Welcome to SKAVL',
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    LongButton('Open former anomaly analysis'),
                    LongButton('Create new anomaly analysis'),
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
    );
  }
}
