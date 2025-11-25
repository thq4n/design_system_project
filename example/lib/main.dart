import 'package:design_system_project/design_system_project.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:design_system_project/components/ds_tooltip/ds_tooltip.dart';

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
        backgroundColor: Colors.white,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            DSTooltip(
              label: 'label tooltip',
              preferBelow: false,
              child: Center(
                child: Container(width: 100, height: 100, color: Colors.red),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
