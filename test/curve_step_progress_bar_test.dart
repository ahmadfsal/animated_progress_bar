import 'package:animated_progress_bar/core/curve_step_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const int totalStepsNumber = 10;
  const int currentStep = 5;
  const Color barColor = Colors.red;
  const Color backgroundColor = Colors.yellow;
  const Duration animationDuration = Duration(seconds: 1);
  const Curve animationCurve = Curves.bounceIn;

  testWidgets('should build CurveStepProgressBar Widget',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: RepaintBoundary(child: CurveStepProgressBar()),
    ));

    expect(
      find.descendant(
          of: find.byType(CurveStepProgressBar),
          matching: find.byType(CustomPaint)),
      findsNWidgets(2),
    );
  });

  testWidgets('should build with given totalStepsNumber and currentStep',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: RepaintBoundary(
          child: CurveStepProgressBar(
            totalStepsNumber: totalStepsNumber,
            currentStep: currentStep,
          ),
        ),
      ),
    );

    await tester.pumpAndSettle();

    await expectLater(
      find.byType(CurveStepProgressBar),
      matchesGoldenFile('golden/withGivenTotalStepsNumberAndCurrentStep.png'),
    );
  });

  testWidgets('should build with given barColor', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: RepaintBoundary(child: CurveStepProgressBar(barColor: barColor)),
      ),
    );

    await expectLater(
      find.byType(CurveStepProgressBar),
      matchesGoldenFile('golden/withGivenBarColor.png'),
    );
  });

  testWidgets('should build with given backgroundColor',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: RepaintBoundary(
            child: CurveStepProgressBar(backgroundColor: backgroundColor)),
      ),
    );

    await expectLater(
      find.byType(CurveStepProgressBar),
      matchesGoldenFile('golden/withGivenBackgroundColor.png'),
    );
  });

  testWidgets('should build with given animationDuration',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: RepaintBoundary(
            child: CurveStepProgressBar(animationDuration: animationDuration)),
      ),
    );

    final widget = find.byType(CurveStepProgressBar);

    await tester.pump(animationDuration);
    await tester.pumpAndSettle();

    expect(widget, findsOneWidget);
  });

  testWidgets('should build with given animationCurve',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home:
            RepaintBoundary(child: CurveStepProgressBar(curve: animationCurve)),
      ),
    );

    final widget = find.byType(CurveStepProgressBar);
    await tester.pumpAndSettle();

    expect(widget, findsOneWidget);
  });

  testWidgets('should build with given parameters defined in above',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: RepaintBoundary(
          child: CurveStepProgressBar(
            totalStepsNumber: totalStepsNumber,
            currentStep: currentStep,
            barColor: barColor,
            backgroundColor: backgroundColor,
            animationDuration: animationDuration,
            curve: animationCurve,
          ),
        ),
      ),
    );

    await tester.pumpAndSettle();

    await expectLater(
      find.byType(CurveStepProgressBar),
      matchesGoldenFile('golden/withGivenAllParameters.png'),
    );
  });
}
