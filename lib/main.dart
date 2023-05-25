import 'package:animated_progress_bar/example.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Curve Step Progress Bar',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const ExamplePage(),
    );
  }
}
