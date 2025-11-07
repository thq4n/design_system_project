import 'package:design_system_project/design_system_project.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() {
  initializeDateFormatting().then((_) => runApp(MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DS Media Picker Demo',
      theme: DSAppTheme.lightTheme,
      home: Scaffold(
        backgroundColor: Colors.black,
        body: SafeArea(
          child: Center(
            child: DSAvatar.text(
              source: 'asds',
              size: DSAvatarSizes.xxl,
              isMale: false,
            ),
          ),
        ),
      ),
    );
  }
}
