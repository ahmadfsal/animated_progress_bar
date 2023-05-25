import 'package:animated_progress_bar/core/curve_step_progress_bar.dart';
import 'package:flutter/material.dart';

class ExamplePage extends StatefulWidget {
  const ExamplePage({
    Key? key,
    this.totalStepsNumber = 5,
    this.currentStep = 2,
  }) : super(key: key);

  // Used for testing
  final int? totalStepsNumber;
  final int? currentStep;

  @override
  State<ExamplePage> createState() => _ExamplePageState();
}


class _ExamplePageState extends State<ExamplePage> {
  Color primaryColor = const Color.fromRGBO(37, 48, 187, 1);

  late int totalStepsNumber;
  late int currentStep;
  int duration = 500;
  Color barColor = Colors.blue;
  Color backgroundColor = Colors.grey;

  final TextEditingController _totalStepsController = TextEditingController();
  final TextEditingController _currentStepsController = TextEditingController();
  final TextEditingController _durationController = TextEditingController();
  Curve curve = Curves.elasticIn;

  final List<Color> _barColorList = [Colors.red, Colors.blue, Colors.yellow];
  final List<Color> _backgroundColorList = [
    Colors.grey,
    Colors.black,
    Colors.lightBlue
  ];

  @override
  void initState() {
    totalStepsNumber = widget.totalStepsNumber!;
    currentStep = widget.currentStep!;

    _totalStepsController.text = widget.totalStepsNumber.toString();
    _currentStepsController.text = widget.currentStep.toString();
    _durationController.text = duration.toString();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Curve Step Progress Bar'),
        centerTitle: true,
        backgroundColor: primaryColor,
      ),
      backgroundColor: Colors.white,
      body: Column(
        children: [
          CurveStepProgressBar(
            currentStep: currentStep,
            totalStepsNumber: totalStepsNumber,
            animationDuration: Duration(milliseconds: duration),
            curve: curve,
            barColor: barColor,
            backgroundColor: backgroundColor,
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(24.0),
              decoration: BoxDecoration(
                color: Colors.lightBlue.shade700,
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(20.0),
                  topLeft: Radius.circular(20.0),
                ),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _actionButton(
                        key: 'tapPrevious',
                        title: 'Previous',
                        onPressed: gotoPreviousStep,
                      ),
                      const Spacer(),
                      _actionButton(
                        key: 'tapNext',
                        title: 'Next',
                        onPressed: gotoNextStep,
                      ),
                    ],
                  ),
                  const SizedBox(height: 40.0),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Properties',
                            style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 16.0),
                          TextFormField(
                            key: const Key('totalStepsController'),
                            controller: _totalStepsController,
                            keyboardType: TextInputType.number,
                            onChanged: (value) {
                              setState(
                                  () => totalStepsNumber = int.parse(value));
                            },
                            decoration: const InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              label: Text('Total Steps Number'),
                            ),
                          ),
                          const SizedBox(height: 16.0),
                          TextFormField(
                            key: const Key('currentStepsController'),
                            controller: _currentStepsController,
                            keyboardType: TextInputType.number,
                            onChanged: (value) {
                              setState(() => currentStep = int.parse(value));
                            },
                            decoration: const InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              label: Text('Current Step'),
                            ),
                          ),
                          const SizedBox(height: 16.0),
                          TextFormField(
                            key: const Key('durationController'),
                            controller: _durationController,
                            keyboardType: TextInputType.number,
                            onChanged: (value) => setState(() {
                              duration = int.parse(value);
                            }),
                            decoration: const InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              label: Text('Duration (milliseconds)'),
                            ),
                          ),
                          const SizedBox(height: 16.0),
                          DropdownButtonFormField(
                            key: const Key('curve'),
                            value: curve,
                            decoration: const InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              label: Text('Curve'),
                            ),
                            onChanged: (Curve? value) {
                              setState(() => curve = value!);
                            },
                            items: CurvesList()
                                .curvesList
                                .map((e) => DropdownMenuItem(
                                      value: e.curve,
                                      child: Text(e.name!),
                                    ))
                                .toList(),
                          ),
                          const SizedBox(height: 16.0),
                          _colors(
                            activeColor: barColor,
                            label: 'Bar Color',
                            list: _barColorList,
                            onTap: (value) {
                              setState(() => barColor = value);
                            },
                          ),
                          const SizedBox(height: 16.0),
                          _colors(
                            activeColor: backgroundColor,
                            label: 'Background Color',
                            list: _backgroundColorList,
                            onTap: (value) {
                              setState(() => backgroundColor = value);
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ACTIVE STEP MUST BE CHECKED FOR (totalStepsNumber - 1) AND NOT FOR totalStepsNumber To PREVENT Overflow ERROR
  void gotoNextStep() {
    if (currentStep < totalStepsNumber - 1) {
      setState(() => currentStep++);
      _currentStepsController.text = currentStep.toString();
    }
  }

  // currentStep MUST BE GREATER THAN 0 TO PREVENT OVERFLOW.
  void gotoPreviousStep() {
    if (currentStep > 0) {
      setState(() => currentStep--);
      _currentStepsController.text = currentStep.toString();
    }
  }

  Widget _actionButton({
    required String title,
    required VoidCallback? onPressed,
    required String key,
  }) {
    return Expanded(
      child: GestureDetector(
        key: Key(key),
        onTap: onPressed,
        child: Container(
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.symmetric(vertical: 12.0),
          decoration: BoxDecoration(
            color: primaryColor,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Center(
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _colors({
    required List<Color> list,
    required void Function(Color value) onTap,
    required String label,
    required Color activeColor,
  }) {
    return Row(
      children: [
        Expanded(
          child: Text(
            label,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: list.map((e) {
              return GestureDetector(
                onTap: () => onTap(e),
                child: Container(
                  height: 32.0,
                  width: 32.0,
                  margin: const EdgeInsets.only(right: 16.0),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: e,
                    border: activeColor == e
                        ? Border.all(width: 4, color: Colors.white)
                        : null,
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}

class CurvesList {
  String? name;
  Curve? curve;

  CurvesList({this.name, this.curve});

  List<CurvesList> get curvesList => [
        CurvesList(name: 'bounceIn', curve: Curves.bounceIn),
        CurvesList(name: 'bounceInOut', curve: Curves.bounceInOut),
        CurvesList(name: 'bounceOut', curve: Curves.bounceOut),
        CurvesList(name: 'decelerate', curve: Curves.decelerate),
        CurvesList(name: 'ease', curve: Curves.ease),
        CurvesList(name: 'easeIn', curve: Curves.easeIn),
        CurvesList(name: 'easeInBack', curve: Curves.easeInBack),
        CurvesList(name: 'easeInCirc', curve: Curves.easeInCirc),
        CurvesList(name: 'easeInCubic', curve: Curves.easeInCubic),
        CurvesList(name: 'easeInExpo', curve: Curves.easeInExpo),
        CurvesList(name: 'easeInOut', curve: Curves.easeInOut),
        CurvesList(name: 'easeInOutBack', curve: Curves.easeInOutBack),
        CurvesList(name: 'easeInOutCirc', curve: Curves.easeInOutCirc),
        CurvesList(name: 'easeInOutCubic', curve: Curves.easeInOutCubic),
        CurvesList(
            name: 'easeInOutCubicEmphasized',
            curve: Curves.easeInOutCubicEmphasized),
        CurvesList(name: 'easeInOutExpo', curve: Curves.easeInOutExpo),
        CurvesList(name: 'easeInOutQuad', curve: Curves.easeInOutQuad),
        CurvesList(name: 'easeInOutQuart', curve: Curves.easeOutQuart),
        CurvesList(name: 'easeInOutQuint', curve: Curves.easeInOutQuint),
        CurvesList(name: 'easeInOutSine', curve: Curves.easeOutSine),
        CurvesList(name: 'easeInQuad', curve: Curves.easeInQuad),
        CurvesList(name: 'easeInQuart', curve: Curves.easeInQuart),
        CurvesList(name: 'easeInQuint', curve: Curves.easeInQuint),
        CurvesList(name: 'easeInSine', curve: Curves.easeInSine),
        CurvesList(name: 'easeInToLinear', curve: Curves.easeInToLinear),
        CurvesList(name: 'easeOut', curve: Curves.easeOut),
        CurvesList(name: 'easeOutBack', curve: Curves.easeOutBack),
        CurvesList(name: 'easeOutCirc', curve: Curves.easeOutCirc),
        CurvesList(name: 'easeOutCubic', curve: Curves.easeOutCubic),
        CurvesList(name: 'easeOutExpo', curve: Curves.easeOutExpo),
        CurvesList(name: 'easeOutQuad', curve: Curves.easeOutQuad),
        CurvesList(name: 'easeOutQuart', curve: Curves.easeOutQuart),
        CurvesList(name: 'easeOutQuint', curve: Curves.easeOutQuint),
        CurvesList(name: 'easeOutSine', curve: Curves.easeOutSine),
        CurvesList(name: 'elasticIn', curve: Curves.elasticIn),
        CurvesList(name: 'elasticInOut', curve: Curves.elasticInOut),
        CurvesList(name: 'elasticOut', curve: Curves.elasticOut),
        CurvesList(
            name: 'fastLinearToSlowEaseIn',
            curve: Curves.fastLinearToSlowEaseIn),
        CurvesList(name: 'fastOutSlowIn', curve: Curves.fastOutSlowIn),
        CurvesList(name: 'linear', curve: Curves.linear),
        CurvesList(name: 'linearToEaseOut', curve: Curves.linearToEaseOut),
        CurvesList(name: 'slowMiddle', curve: Curves.slowMiddle),
      ];
}
