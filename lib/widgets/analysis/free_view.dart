import 'dart:math';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skavl/widgets/image_selection_overlay.dart';
import 'package:skavl/widgets/opacity_slider.dart';
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

  // Opacity tracking
  final Map<String, Map<String, double>> savedOpacities = {};
  final Map<String, double> opacities = {};

  // Image selection tracking
  String? selectedId;
  Offset? _pointerDownPos;
  String? _pointerDownHitId;

  static const double _clickThreshold = 5.0;

  //----------------------------------

  /// Override of getting opacity from given source if one exists in memory.
  @override
  double getOpacityForSource(String sourceId) => opacities[sourceId] ?? 1.0;

  /// Calculate screen rect size for displaying source text
  Rect? _selectionScreenRect(String sourceId) {
    final sceneRect = resolveRectSafe(sourceId);
    if (sceneRect == null) return null;

    final topLeft = tc.value.transform3(Vector3(sceneRect.left, sceneRect.top, 0));
    final bottomRight = tc.value.transform3(Vector3(sceneRect.right, sceneRect.bottom, 0));
    final transformed = Rect.fromLTRB(topLeft.x, topLeft.y, bottomRight.x, bottomRight.y);

    final viewportSize = lastViewportSize ?? Size.zero;
    final viewport = Rect.fromLTWH(0, 0, viewportSize.width, viewportSize.height);

    final intersected = transformed.intersect(viewport);
    if (intersected.isEmpty) return null;
    return intersected;
  }

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
    if (project.currentPage == _lastPage &&
        project.sensitivity == _lastSensitivity) {
      return;
    }
    _loadCurrentPage(project);
  }

  void _loadCurrentPage(ProjectMetadata project) {
    final paths = getWindowPaths(project, ViewMode.free.imageCount);
    if (paths.isEmpty) return;

    // Save current positions and opacity before navigating away
    if (_lastPage != null) {
      final currentAnomalies = project.anomaliesInRange;
      if (_lastPage! < currentAnomalies.length) {
        final currentAnomalyName = currentAnomalies[_lastPage!].imageName;
        if (positions.isNotEmpty) {
          savedPositions[currentAnomalyName] = Map.from(positions);
        }
        if (opacities.isNotEmpty) {
          savedOpacities[currentAnomalyName] = Map.from(opacities);
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

      final savedPos = anomalyName != null ? savedPositions[anomalyName] : null;
      final savedOp = anomalyName != null ? savedOpacities[anomalyName] : null;

      setState(() {
        positions.clear();
        opacities.clear();
        selectedId = null;
        for (final id in sceneController.sourceOrder) {
          positions[id] =
              savedPos?[id] ??
              Offset(
                Random().nextDouble() * 20000,
                Random().nextDouble() * 20000,
              );
          if (savedOp?[id] != null) {
            opacities[id] = savedOp![id]!;
          }
        }
        pendingInitialPlan = true;
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
    return Stack(
      children: [
        Listener(
          onPointerDown: (event) {
            handlePanPointerDown(event);
            if (event.buttons == kPrimaryMouseButton) {
              _pointerDownPos = event.localPosition;
              _pointerDownHitId = _hitTest(_toScene(event.localPosition));
              draggingId = _pointerDownHitId;
            }
          },
          onPointerMove: (event) {
            handlePanPointerMove(event);
            if (draggingId != null && event.pointer != panPointer) {
              final scale = tc.value.getMaxScaleOnAxis();
              setState(() {
                positions[draggingId!] =
                    positions[draggingId!]! + event.delta / scale;
              });
              scheduleViewportPlan();
            }
          },
          onPointerUp: (event) {
            handlePanPointerUp(event);
            if (_pointerDownPos != null) {
              final moved = (event.localPosition - _pointerDownPos!).distance;
              // Determine if click or drag
              if (moved < _clickThreshold) {
                setState(() {
                  if (selectedId != null) {
                    // Deselect any image when clicked
                    selectedId = null;
                  } else {
                    // Select image if no image is selected
                    selectedId = _pointerDownHitId;
                  }
                });
              }
            }
            draggingId = null;
            _pointerDownPos = null;
            _pointerDownHitId = null;
          },
          onPointerCancel: (event) {
            handlePanPointerUp(event);
            draggingId = null;
            _pointerDownPos = null;
            _pointerDownHitId = null;
          },
          child: InteractiveViewer(
            transformationController: tc,
            minScale: 0.005,
            maxScale: 4,
            boundaryMargin: EdgeInsets.zero,
            constrained: false,
            panEnabled: false,
            child: Stack(
              children: [
                SizedBox(
                  width: sceneSize,
                  height: sceneSize,
                  child: CustomPaint(
                    painter: GridPainter(
                      thinColor:
                          Theme.of(context).brightness == Brightness.light
                          ? MyColors.secondaryBlack
                          : MyColors.primaryWhite,
                      thickColor:
                          Theme.of(context).brightness == Brightness.light
                          ? MyColors.secondaryBlack
                          : MyColors.primaryWhite,
                    ),
                  ),
                ),
                child, // tile stack
              ],
            ),
          ),
        ),
        // Image selection logic for clearly showing user which image is selected.
        if (selectedId != null)
          AnimatedBuilder(
            animation: tc,
            builder: (context, _) {
              final selRect = _selectionScreenRect(selectedId!);
              if (selRect == null) return const SizedBox.shrink();
              return Stack(
                children: [
                  ImageSelectionOverlay(screenRect: selRect, label: selectedId!),
                  _buildSliderOverlay(),
                ],
              );
            },
          ),
      ],
    );
  }

  /// Builds a lider widget as an overlay on the selected image.
  ///
  /// The slider is positioned at the top-right corner of the image.
  /// If the image bounds are outside of the viewport, slider anchors in the top right corner of the viewport.
  Widget _buildSliderOverlay() {
    final rect = resolveRectSafe(selectedId!);
    if (rect == null) return const SizedBox.shrink();

    final topRight = tc.value.transform3(Vector3(rect.right, rect.top, 0));
    final viewportSize = lastViewportSize ?? Size.zero;

    final left = topRight.x.clamp(0.0, viewportSize.width - 80);
    final top = topRight.y.clamp(80.0, viewportSize.height - 280);

    return Positioned(
      left: left,
      top: top,
      child: VerticalSlider(
        value: opacities[selectedId!] ?? 1.0,
        onChanged: (v) => setState(() => opacities[selectedId!] = v),
      ),
    );
  }
}
