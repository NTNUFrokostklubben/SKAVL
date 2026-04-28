import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vector_math/vector_math_64.dart';
import 'base_analysis_view.dart';
import 'package:skavl/entity/project_metadata.dart';
import 'package:skavl/entity/view_mode.dart';
import 'package:skavl/services/project_manager_service.dart';
import 'package:skavl/theme/grid_painter.dart';
import 'package:skavl/theme/colors.dart';

/// View mode where the user can freely arrange the images in the scene by dragging them around.
///
/// Implemented by maintaining a map of source IDs to their positions in the scene,
/// using custom hit testing and coordinate conversion to allow dragging the images with the mouse.
class FreeView extends BaseAnalysisView {
  const FreeView({super.key});

  @override
  State<FreeView> createState() => _FreeViewState();
}

class _FreeViewState extends BaseTileViewState<FreeView> {
  static const double sceneSize = 300000;

  late final ProjectManagerService _projectManager;
  int? _lastPage;
  double? _lastSensitivity;

  final Map<String, Offset> positions = {};
  final Map<String, Map<String, Offset>> savedPositions = {};
  String? draggingId;

  //----------------------------------

  @override
  void initState() {
    super.initState();
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
    final paths = getWindowPaths(project, ViewMode.free.imageCount);
    if (paths.isEmpty) return;

    // Save current positions before navigating away
    if (_lastPage != null) {
      final currentAnomalies = project.anomaliesInRange;
      if (_lastPage! < currentAnomalies.length) {
        final currentAnomalyName = currentAnomalies[_lastPage!].imageName;
        if (positions.isNotEmpty) {
          savedPositions[currentAnomalyName] = Map.from(positions);
        }
      }
    }

    _lastPage = project.currentPage;
    _lastSensitivity = project.sensitivity;

    sceneController.loadSources(paths).then((_) {
      if (!mounted) return;

      final anomalies = project.anomaliesInRange;
      final anomalyName = project.currentPage < anomalies.length
          ? anomalies[project.currentPage].imageName
          : null;

      final saved = anomalyName != null ? savedPositions[anomalyName] : null;

      setState(() {
        positions.clear();
        for (final id in sceneController.sourceOrder) {
          positions[id] =
              saved?[id] ??
              Offset(
                Random().nextDouble() * 20000,
                Random().nextDouble() * 20000,
              );
        }
      });
    });
  }

  @override
  List<String> getImagePaths() => [];

  // Return a big rect for the whole scene since we handle custom positioning in resolveRectSafe
  @override
  Rect getSceneRect() => const Rect.fromLTWH(0, 0, sceneSize, sceneSize);

  @override
  Rect? resolveRectSafe(String sourceId) {
    final pos = positions[sourceId];
    final desc = sceneController.sourcesById[sourceId];
    if (pos == null || desc == null) return null;
    return Rect.fromLTWH(
      pos.dx,
      pos.dy,
      desc.descriptor.sourceWidthPx.toDouble(),
      desc.descriptor.sourceHeightPx.toDouble(),
    );
  }

  @override
  Map<String, Rect>? getCustomRects() {
    final rects = <String, Rect>{};
    for (final id in sceneController.sourceOrder) {
      final r = resolveRectSafe(id);
      if (r != null) rects[id] = r;
    }
    return rects;
  }

  /// Convert local widget coordinates to scene coordinates using the inverse of the transformation matrix
  Offset _toScene(Offset local) {
    final inverse = Matrix4.inverted(tc.value);
    final vec = inverse.transform3(Vector3(local.dx, local.dy, 0));
    return Offset(vec.x, vec.y);
  }

  /// Hit test the scene point against the images in reverse order (topmost first) to find which one is being interacted with
  String? _hitTest(Offset scenePoint) {
    for (final id in sceneController.sourceOrder.reversed) {
      final r = resolveRectSafe(id);
      if (r != null && r.contains(scenePoint)) return id;
    }
    return null;
  }

  @override
  Widget buildViewport(Widget child) {
    return Listener(
      onPointerDown: (event) {
        draggingId = _hitTest(_toScene(event.localPosition));
      },
      onPointerMove: (event) {
        if (draggingId == null) return;
        final scale = tc.value.getMaxScaleOnAxis();
        setState(() {
          positions[draggingId!] =
              positions[draggingId!]! + event.delta / scale;
        });
        scheduleViewportPlan();
      },
      onPointerUp: (_) => draggingId = null,
      onPointerCancel: (_) => draggingId = null,
      child: InteractiveViewer(
        transformationController: tc,
        minScale: 0.005,
        maxScale: 4,
        boundaryMargin: EdgeInsets.zero,
        constrained: false,
        panEnabled: draggingId == null,
        child: Stack(
          children: [
            SizedBox(
              width: sceneSize,
              height: sceneSize,
              child: CustomPaint(
                painter: GridPainter(
                  thinColor: Theme.of(context).brightness == Brightness.light
                      ? MyColors.secondaryBlack
                      : MyColors.primaryWhite,
                  thickColor: Theme.of(context).brightness == Brightness.light
                      ? MyColors.secondaryBlack
                      : MyColors.primaryWhite,
                ),
              ),
            ),
            child, // tile stack
          ],
        ),
      ),
    );
  }
}
