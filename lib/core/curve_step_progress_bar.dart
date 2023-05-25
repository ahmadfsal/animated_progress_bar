import 'package:animated_progress_bar/core/painters/dot_offset.dart';
import 'package:animated_progress_bar/core/painters/indicator_painter.dart';
import 'package:animated_progress_bar/core/painters/fixed_dot_painter.dart';
import 'package:flutter/material.dart';

class CurveStepProgressBar extends StatefulWidget {
  final int? totalStepsNumber;
  final int? currentStep;
  final Duration? animationDuration;
  final Color? barColor;
  final Color? backgroundColor;
  final Curve? curve;

  const CurveStepProgressBar({
    Key? key,
    this.totalStepsNumber = 3,
    this.currentStep = 0,
    this.barColor = const Color.fromRGBO(37, 48, 187, 1),
    this.backgroundColor = Colors.grey,
    this.animationDuration = const Duration(milliseconds: 500),
    this.curve = Curves.elasticOut,
  }) : super(key: key);

  @override
  _CurveStepProgressBarState createState() => _CurveStepProgressBarState();
}

class _CurveStepProgressBarState extends State<CurveStepProgressBar>
    with SingleTickerProviderStateMixin {
  AnimationController? _animationController;

  double spacing = 16.0;
  double radius = 12.0;

  int? _activeDotIndex;
  int? _oldDotIndex;
  Paint? _fixedDotFillBrush;
  Paint? _indicatorBrush;

  @override
  void initState() {
    _animationController = AnimationController(
      duration: widget.animationDuration,
      vsync: this,
    );

    _animationController!.addListener(() => setState(() {}));
    _animationController!.forward();

    _activeDotIndex = widget.currentStep;
    _oldDotIndex = 0;

    _fixedDotFillBrush = Paint()..color = widget.backgroundColor!;
    _indicatorBrush = Paint()..color = widget.barColor!;

    super.initState();
  }

  @override
  void dispose() {
    _animationController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.all(32.0),
      alignment: Alignment.center,
      child: Stack(
        children: [
          CustomPaint(
            size: Size(_axisLength, _diameter),
            painter: FixedDotPainter(
              totalStepNumber: widget.totalStepsNumber!,
              currentStep: _activeDotIndex!,
              barColor: widget.barColor!,
              backgroundColor: widget.backgroundColor!,
              dotRadius: radius,
              dotOffsets: _buildDotOffsets,
              fillBrush: _fixedDotFillBrush,
            ),
          ),
          CustomPaint(
            painter: IndicatorPainter()
              ..activeDotOffset = _buildDotOffsets[_activeDotIndex!]
              ..oldDotOffset = _buildDotOffsets[_oldDotIndex!]
              ..brush = _indicatorBrush
              ..animationController = _animationController
              ..curve = widget.curve,
          ),
        ],
      ),
    );
  }

  /// Builds and returns the dot offsets.
  List<DotOffset> get _buildDotOffsets {
    List<DotOffset> dotOffsets = [];

    // Create and save the first offset.
    Offset center = Offset(radius, radius);
    dotOffsets.add(DotOffset(center, radius));

    // Create successive offsets by translating and save them to the list.
    for (int index = 0; index < (widget.totalStepsNumber! - 1); index++) {
      center = center.translate(_diameter + spacing, 0.0);

      dotOffsets.add(DotOffset(center, radius));
    }

    return dotOffsets;
  }

  /// Returns the width or height
  double get _axisLength =>
      (_diameter * widget.totalStepsNumber!) + _totalSpacing;

  /// Returns the total amount of spacing between the dots. The spacing after the last dot is omitted.
  double get _totalSpacing => spacing * (widget.totalStepsNumber! - 1);

  /// Returns the diameter of a dot.
  double get _diameter => radius * 2;

  @override
  void didUpdateWidget(covariant CurveStepProgressBar oldWidget) {
    // Update old and active dot indices.
    _oldDotIndex = oldWidget.currentStep;
    _fixedDotFillBrush = Paint()..color = widget.backgroundColor!;
    _indicatorBrush = Paint()..color = widget.barColor!;

    _animationController!.reset();
    _animationController!.forward();

    _activeDotIndex = widget.currentStep;

    super.didUpdateWidget(oldWidget);
  }
}
