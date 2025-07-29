import 'package:flutter/material.dart';
import 'package:design_system_project/design_system_project.dart';
import 'simple_shimmer_test.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shimmer Loading Demo',
      theme: ThemeData(primarySwatch: Colors.blue, useMaterial3: true),
      home: const SimpleShimmerTest(),
    );
  }
}
