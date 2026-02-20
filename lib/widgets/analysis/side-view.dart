import 'dart:io';

import 'package:flutter/cupertino.dart';

class SideView extends StatelessWidget {
  const SideView({super.key});

  static const String imgPath = "C:\\Users\\Admin\\Documents\\bachelor-thesis\\ImageDataTest\\NordmøreGSD10";

  @override
  Widget build(BuildContext context) {
    final file = File(imgPath);
    return const Center(
      child: Column(
        children: [
          Text("Side by Side View"),

        ],
      ),
    );
  }

}