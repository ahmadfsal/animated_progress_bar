import 'package:animated_progress_bar/example.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  int _totalStepsNumber = 10;
  int _currentStep = 5;

  testWidgets(
    'should show initial text with given currentStep',
    (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: ExamplePage(
            totalStepsNumber: _totalStepsNumber,
            currentStep: _currentStep,
          ),
        ),
      );

      final totalStepsController = find.descendant(
        of: find.byKey(const Key('totalStepsController')),
        matching: find.byType(EditableText),
      );
      final totalSteps = tester.widget<EditableText>(totalStepsController);
      final currentStepsController = find.descendant(
        of: find.byKey(const Key('currentStepsController')),
        matching: find.byType(EditableText),
      );
      final currentStep = tester.widget<EditableText>(currentStepsController);

      expect(totalSteps.controller.text, _totalStepsNumber.toString());
      expect(currentStep.controller.text, _currentStep.toString());
    },
  );

  testWidgets(
    'should currentStep increment when tap Next Button',
    (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: ExamplePage(
            totalStepsNumber: _totalStepsNumber,
            currentStep: _currentStep,
          ),
        ),
      );

      await tester.tap(find.byKey(const Key('tapNext')));
      await tester.pumpAndSettle();

      final currentStepsController = find.descendant(
        of: find.byKey(const Key('currentStepsController')),
        matching: find.byType(EditableText),
      );
      final currentStep = tester.widget<EditableText>(currentStepsController);

      expect(currentStep.controller.text, equals('6'));
    },
  );

  testWidgets(
    'should currentStep decrement when tap Previous Button',
    (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: ExamplePage(
            totalStepsNumber: _totalStepsNumber,
            currentStep: _currentStep,
          ),
        ),
      );

      await tester.tap(find.byKey(const Key('tapPrevious')));
      await tester.pumpAndSettle();

      final currentStepsController = find.descendant(
        of: find.byKey(const Key('currentStepsController')),
        matching: find.byType(EditableText),
      );
      final currentStep = tester.widget<EditableText>(currentStepsController);

      expect(currentStep.controller.text, equals('4'));
    },
  );
}
