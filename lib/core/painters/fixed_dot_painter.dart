import 'package:animated_progress_bar/core/painters/dot_offset.dart';
import 'package:flutter/material.dart';

class FixedDotPainter extends CustomPainter {
  FixedDotPainter({
    required this.totalStepNumber,
    required this.currentStep,
    required this.dotOffsets,
    required this.fillBrush,
    required this.dotRadius,
    required this.barColor,
    required this.backgroundColor,
  });

  final int totalStepNumber;
  final int currentStep;
  final double dotRadius;
  final List<DotOffset> dotOffsets;
  final Paint? fillBrush;
  final Color barColor;
  final Color backgroundColor;

  @override
  void paint(Canvas canvas, Size size) {
    for (int index = 0; index < totalStepNumber; index++) {
      canvas.drawRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTRB(
            dotOffsets[index].left,
            dotOffsets[index].top,
            dotOffsets[index].right,
            dotOffsets[index].bottom,
          ),
          const Radius.circular(1000),
        ),
        fillBrush!,
      );
    }

    _drawLineConnectors(canvas);
  }

  void _drawLineConnectors(Canvas canvas) {
    double linePadding = 4.0;
    Paint paint = Paint();

    paint
      ..strokeWidth = 4.0
      ..color = Colors.grey;

    for (int index = 0; index < totalStepNumber - 1; index++) {
      canvas.drawLine(
        Offset(
          dotOffsets[index].right + linePadding,
          dotRadius,
        ),
        Offset(
          dotOffsets[index + 1].left - linePadding,
          dotRadius,
        ),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(FixedDotPainter oldDelegate) => true;
}
