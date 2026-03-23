import 'package:flutter/material.dart';

/// A custom painter that draws a grid on the canvas, with thin lines every 320 pixels and thick lines every 1600 pixels.
class GridPainter extends CustomPainter {
  const GridPainter({required this.thinColor, required this.thickColor});

  final Color thinColor; // Color of the thin lines in the grid
  final Color thickColor; // color of the thicker lines in the grid
  final double smallCellSize = 320.0;
  final double largeCellSize = 1600.0;

  @override
  void paint(Canvas canvas, Size size) {
    final thinPaint = Paint()
      ..color = thinColor
      ..strokeWidth = 0.5
      ..style = PaintingStyle.stroke;

    final thickPaint = Paint()
      ..color = thickColor
      ..strokeWidth = 1.0
      ..style = PaintingStyle.stroke;

    for (double x = 0; x <= size.width; x += smallCellSize) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), thinPaint);
    }
    for (double y = 0; y <= size.height; y += smallCellSize) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), thinPaint);
    }
    for (double x = 0; x <= size.width; x += largeCellSize) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), thickPaint);
    }
    for (double y = 0; y <= size.height; y += largeCellSize) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), thickPaint);
    }
  }

  @override
  bool shouldRepaint(GridPainter old) =>
      old.smallCellSize != smallCellSize ||
      old.largeCellSize != largeCellSize ||
      old.thinColor != thinColor ||
      old.thickColor != thickColor;
}
