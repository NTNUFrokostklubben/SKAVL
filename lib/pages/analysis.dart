import 'package:flutter/material.dart';
import 'package:skavl/widgets/analysis/free_view.dart';
import 'package:skavl/widgets/analysis/static_view.dart';
import 'package:skavl/widgets/top_bar.dart';
import 'package:skavl/widgets/anomaly_classif_bar.dart';
import 'package:skavl/entity/view_mode.dart';

class Analysis extends StatefulWidget {
  const Analysis({super.key});

  @override
  State<Analysis> createState() => _AnalysisState();
}

class _AnalysisState extends State<Analysis> {
  ViewMode mode = ViewMode.horizontal;

  @override
  Widget build(BuildContext context) {
    final index = ViewMode.values.indexOf(mode);
    return Scaffold(
      appBar: TopBar(foreignContext: context),
      body: Row(
        children: [
          // TODO make this in norwegian too (app localizationd)
          // Toolbar
          NavigationRail(
            destinations: const [
              NavigationRailDestination(
                icon: Icon(Icons.view_column),
                label: Text("Horrizontal"),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.view_stream),
                label: Text("Vertical"),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.layers_outlined),
                label: Text("Overlay"),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.grid_view),
                label: Text("Grid 2x2"),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.grid_3x3),
                label: Text("Grid 3x3"),
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
          Expanded(
            child: IndexedStack(
              index: index,
              children: const [
                StaticView(viewMode: ViewMode.horizontal),
                StaticView(viewMode: ViewMode.vertical),
                Text("Overlay"),
                StaticView(viewMode: ViewMode.gridsmall),
                StaticView(viewMode: ViewMode.gridbig),
                FreeView(),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: AnomalyClassifBar(),
    );
  }
}
