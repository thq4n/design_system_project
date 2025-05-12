// lib/main.dart
import 'package:flutter/material.dart';
import 'theme/app_theme.dart';
import 'components/button.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Design System Project',
      theme: AppTheme.lightTheme, // Sử dụng theme đã định nghĩa
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Design System Example')),
      body: Center(
        child: CustomButton(
          text: 'Press Me',
          onPressed: () {
            print('Button Pressed!');
          },
        ),
      ),
    );
  }
}
