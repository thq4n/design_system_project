// lib/main.dart
import 'package:flutter/material.dart';

import 'components/button.dart';
import 'design_system_core/ds_icon/ds_icon_core.dart';
import 'theme/app_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Design System Project',
      theme: AppTheme.lightTheme, // Sử dụng theme đã định nghĩa
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    const icon = const Icon(DSIcons.dcubeBold);

    return Scaffold(
      appBar: AppBar(title: const Text('Design System Example')),
      body: Center(
        child: Column(
          children: [
            icon,
            CustomButton(
              text: 'Press Me',
              onPressed: () {
                print(icon.toStringDeep());
              },
            ),
          ],
        ),
      ),
    );
  }
}
