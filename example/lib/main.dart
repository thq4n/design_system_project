import 'package:design_system_project/design_system_project.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DS Media Picker Demo',
      theme: DSAppTheme.lightTheme,
      home: Scaffold(
        body: Center(
          child: DSMediaPicker(controller: DSMediaPickerController()),
        ),
      ),
    );
  }
}
