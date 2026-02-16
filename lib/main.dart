import 'package:flutter/material.dart';
import 'l10n/app_localizations.dart';

import 'package:skavl/widgets/long_button.dart';
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

  AppLocalizations? loc() {
    return AppLocalizations.of(context);
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
                    Text(
                      loc()!.welcomeSKAVL,
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    LongButton(loc()!.openFormer),
                    LongButton(loc()!.createNew),
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
