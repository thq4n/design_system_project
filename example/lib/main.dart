import 'package:design_system_project/design_system_project.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:design_system_project/components/ds_tag/ds_tag.dart';

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
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: DSTag(
                label: 'Tag',
                size: DSTagSizes.md,
                style: DSTagStyles.info,
                suffixIcon: DSAssets.vuesax.a24SupportBold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
