# curve_step_progress_bar

The Step Progress Bar widgets allow you to visually notify users about their current position as they scroll through a group of pages.

## Usage

```dart
CurveStepProgressBar(
    totalStepsNumber: 10,
    currentStep: 5,
    barColor: Colors.red,
    backgroundColor: Colors.yellow,
    animationDuration: const Duration(seconds: 1),
    curve: Curves.bounceIN
),
```

## CurveStepProgressBar Parameters

| Parameter         | Type       | Description                                                     | Default                                |
| ----------------- | ---------- | --------------------------------------------------------------- | -------------------------------------- |
| totalStepsNumber  | `int`      | Total number of step of the complete indicator                  | 5                                      |
| currentStep       | `int`      | Number of active steps to show indicator barColor               | 3                                      |
| barColor          | `Color`    | Color of the active steps                                       | `const Color.fromRGBO(37, 48, 187, 1)` |
| backgroundColor   | `Color`    | Color of the all steps                                          | `Colors.grey`                          |
| animationDuration | `Duration` | How long animate between steps when the current step is changed | `const Duration(milliseconds: 500)`    |
| curve             | `Curve`    | Selected curve to show the animation                            | `Curves.elasticOut`                    |

## Running

1. Clone this project `git clone https://github.com/ahmadfsal/animated_progress_bar.git`
2. Run `flutter pub get`
3. Run `flutter run`

## Testing

This widget using Golden tests to generate a screenshot of the widget and compares it against a reference image. If both the images match, the test will pass.

-   Widget testing
    -   run `flutter test test/widget_test.dart`
-   Unit testing
    -   run this command to generate screenshot first
        `flutter test --update-goldens test/curve_step_progress_bar_test.dart`
    -   then run `flutter test test/curve_step_progress_bar_test.dart`
