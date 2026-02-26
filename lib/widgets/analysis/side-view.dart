import 'package:flutter/material.dart';


class SideView extends StatefulWidget {
  const SideView({super.key});

  @override
  State<SideView> createState() => _SideViewState();
}

class _SideViewState extends State<SideView> {
  late final TransformationController _tc;

  @override
  void initState() {
    super.initState();
    _tc = TransformationController();
  }

  @override
  void dispose() {
    _tc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return SizedBox.expand(
      child: InteractiveViewer(child: Text("data"), transformationController: _tc,)
    );
  }
}

