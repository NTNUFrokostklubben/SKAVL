import 'package:flutter/material.dart';
import 'package:skavl/entity/view_mode.dart';
import 'base_analysis_view.dart';

/// A view mode where the images are arranged in a fixed layout based on the selected view mode (e.g. horizontal, vertical, grid2x2, grid3x3).
/// the layout is static and defined by the scene layout in the TileSceneController, which is built based on the view mode and the loaded sources.
class StaticView extends BaseAnalysisView {
  final ViewMode viewMode;

  const StaticView({super.key, required this.viewMode});

  @override
  State<StaticView> createState() => _StaticViewState();
}

/// The state for StaticView, which initializes the scene layout based on the selected view mode and loads the sources for the images to be displayed.
class _StaticViewState extends BaseTileViewState<StaticView> {
  final imagePaths = [
    r"C:\Users\sigbe\Documents\Skoleaar_25_26\Semester_6\Bachelor\HX_14365_NORDMORE_GSD10\RGB\HX-14365_001_001_00001.tif",
    r"C:\Users\sigbe\Documents\Skoleaar_25_26\Semester_6\Bachelor\HX_14365_NORDMORE_GSD10\RGB\HX-14365_001_002_00002.tif",
    r"C:\Users\sigbe\Documents\Skoleaar_25_26\Semester_6\Bachelor\HX_14365_NORDMORE_GSD10\RGB\HX-14365_001_003_00003.tif",
    r"C:\Users\sigbe\Documents\Skoleaar_25_26\Semester_6\Bachelor\HX_14365_NORDMORE_GSD10\RGB\HX-14365_001_004_00004.tif",
    r"C:\Users\sigbe\Documents\Skoleaar_25_26\Semester_6\Bachelor\HX_14365_NORDMORE_GSD10\RGB\HX-14365_001_005_00005.tif",
    r"C:\Users\sigbe\Documents\Skoleaar_25_26\Semester_6\Bachelor\HX_14365_NORDMORE_GSD10\RGB\HX-14365_001_006_00006.tif",
    r"C:\Users\sigbe\Documents\Skoleaar_25_26\Semester_6\Bachelor\HX_14365_NORDMORE_GSD10\RGB\HX-14365_001_007_00007.tif",
    r"C:\Users\sigbe\Documents\Skoleaar_25_26\Semester_6\Bachelor\HX_14365_NORDMORE_GSD10\RGB\HX-14365_001_008_00008.tif",
    r"C:\Users\sigbe\Documents\Skoleaar_25_26\Semester_6\Bachelor\HX_14365_NORDMORE_GSD10\RGB\HX-14365_001_009_00009.tif",
  ];

  @override
  List<String> getImagePaths() => imagePaths;

  @override
  void initState() {
    super.initState();
    sceneController.viewMode = widget.viewMode;
    sceneController.loadSources(imagePaths);
  }

  @override
  Widget buildViewport(Widget child) {
    return InteractiveViewer(
      transformationController: tc,
      minScale: 0.005,
      maxScale: 3,
      boundaryMargin: EdgeInsets.all(double.infinity),
      constrained: false,
      child: child,
    );
  }

  @override
  Rect getSceneRect() {
    final layout = sceneController.sceneLayout!;
    return Offset.zero & layout.sceneSize;
  }

  @override
  Rect? resolveRectSafe(String sourceId) {
    return sceneController.sceneLayout?.panelRects[sourceId];
  }

  @override
  Map<String, Rect>? getCustomRects() => null;
}
