import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skavl/controller/tile_scene_controller.dart';
import 'package:skavl/entity/project_metadata.dart';
import 'package:skavl/entity/view_mode.dart';
import 'package:skavl/services/project_manager_service.dart';
import 'base_analysis_view.dart';

/// View mode where the images are arranged in a fixed layout based on the selected [ViewMode] (e.g. horizontal, vertical, grid2x2, grid3x3).
///
/// Layout is static and defined by the scene layout in the [TileSceneController], which is built based on the [ViewMode] and the loaded sources.
class StaticView extends BaseAnalysisView {
  final ViewMode viewMode;

  const StaticView({super.key, required this.viewMode});

  @override
  State<StaticView> createState() => _StaticViewState();
}

class _StaticViewState extends BaseTileViewState<StaticView> {

  late final ProjectManagerService _projectManager;
  int? _lastPage;
  double? _lastSensitivity;

  @override
  void initState() {
    super.initState();
    sceneController.viewMode = widget.viewMode;
    _projectManager = context.read<ProjectManagerService>();
    _projectManager.addListener(_onProjectChanged);

    final project = _projectManager.loadedProject;
    if (project != null) _loadCurrentPage(project);
  }

  @override
  void dispose() {
    _projectManager.removeListener(_onProjectChanged);
    super.dispose();
  }

  void _onProjectChanged() {
    if (!mounted) return;
    final project = _projectManager.loadedProject;
    if (project == null) return;
    if (project.currentPage == _lastPage && project.sensitivity == _lastSensitivity) return;
    _loadCurrentPage(project);
  }

  void _loadCurrentPage(ProjectMetadata project) {
    final paths = getWindowPaths(project, widget.viewMode.imageCount);
    if (paths.isEmpty) return;
    _lastPage = project.currentPage;
    _lastSensitivity = project.sensitivity;
    sceneController.viewMode = widget.viewMode;
    sceneController.loadSources(paths);
  }

  @override
  List<String> getImagePaths() => [];

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
