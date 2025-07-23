import 'package:flutter/material.dart';
import 'package:design_system_project/design_system_project.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: DSAppTheme.lightTheme,
      darkTheme: DSAppTheme.darkTheme,
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String? _selectedRadioValue = 'groupValue';
  DSTextTheme get textTheme =>
      Theme.of(context).extension<DSTextThemeExtension>()!.textTheme;
  final DSInputController controller = DSInputController();

  @override
  Widget build(BuildContext context) {
    return DSBasicScreenForm(
      title: 'Basic Screen Form Demo',
      showBackButton: true,
      centerTitle: true,

      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            DSRadio<String>(
              value: 'value',
              groupValue: _selectedRadioValue,
              onChanged: (value) {
                print('value: $value');
                setState(() {
                  _selectedRadioValue = value;
                });
              },
            ),
            DSRadio<String>(
              value: 'value2',
              groupValue: _selectedRadioValue,
              onChanged: (value) {
                print('value: $value');
                setState(() {
                  _selectedRadioValue = value;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
