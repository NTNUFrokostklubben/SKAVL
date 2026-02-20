import 'package:flutter/material.dart';
import 'package:skavl/widgets/top_bar.dart';

/// View modes displayed on the toolbar
enum ViewMode { side, overlay, grid, free }

class Analysis extends StatefulWidget {
  const Analysis({super.key});

  @override
  State<Analysis> createState() => _AnalysisState();
}

class _AnalysisState extends State<Analysis> {
  ViewMode mode = ViewMode.grid;

  @override
  Widget build(BuildContext context) {
    final index = ViewMode.values.indexOf(mode);
    return Scaffold(
      appBar: TopBar(foreignContext: context),
      body: Row(
        children: [
          // Toolbar
          NavigationRail(
            destinations: const [
              NavigationRailDestination(
                icon: Icon(Icons.window),
                label: Text("Side by Side"),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.layers_outlined),
                label: Text("Overlay"),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.grid_3x3),
                label: Text("Grid"),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.view_module),
                label: Text("Free"),
              ),
            ],
            selectedIndex: index,
            onDestinationSelected: (i) => setState(() {
              mode = ViewMode.values[i];
            }),
            labelType: NavigationRailLabelType.none,
          ),

          const VerticalDivider(width: 1),

          // Main work pane
          Expanded(child: _AnalysisBody(mode: mode)),
        ],
      ),
    );
  }
}

/// Internal handler to display different view modes in the work-pane
class _AnalysisBody extends StatelessWidget {
  final ViewMode mode;

  const _AnalysisBody({required this.mode});

  @override
  Widget build(BuildContext context) {
    switch (mode) {
      case ViewMode.side:
        return const Text("Side");
      case ViewMode.overlay:
        return const Text("Overlay");
      case ViewMode.grid:
        return const Text("Grid");
      case ViewMode.free:
        return const Text("Free");
    }
  }
}
