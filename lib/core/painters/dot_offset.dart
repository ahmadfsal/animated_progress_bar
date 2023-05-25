import 'package:flutter/material.dart';

/// Takes center and radius of a dot, then calculates the left-dx, top-dy, right-dx, and bottom-dy of a dot.
class DotOffset {
  DotOffset(this._center, this._dotRadius);

  final Offset _center;
  final double _dotRadius;

  double get left => _center.dx - _dotRadius;
  double get top => _center.dy - _dotRadius;
  double get right => _center.dx + _dotRadius;
  double get bottom => _center.dy + _dotRadius;
  double get center => _center.dx;
}
