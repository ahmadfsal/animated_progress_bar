import 'package:animated_progress_bar/core/painters/dot_offset.dart';
import 'package:flutter/material.dart';

class IndicatorPainter extends CustomPainter {
  double? dotRadius;
  DotOffset? activeDotOffset;
  DotOffset? oldDotOffset;
  Paint? brush;
  Paint? borderBrush;
  AnimationController? animationController;
  Curve? curve;

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTRB(
          oldDotOffset!.left,
          oldDotOffset!.top,
          oldDotOffset!.right,
          oldDotOffset!.bottom,
        ).translate(slide.value, 0),
        const Radius.circular(1000),
      ),
      brush!,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;

  Animation get slide => Tween(
        begin: 0.0,
        end: activeDotOffset!.left - (oldDotOffset!.left - 1),
      ).animate(CurvedAnimation(
        parent: animationController!,
        curve: curve!,
      ));
}
