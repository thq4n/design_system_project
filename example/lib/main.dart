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
  int _counter = 0;
  DSTextTheme get textTheme =>
      Theme.of(context).extension<DSTextThemeExtension>()!.textTheme;
  final DSInputController controller = DSInputController();

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DSBasicScreenForm(
      title: 'Basic Screen Form Demo',
      showBackButton: true,
      centerTitle: true,

      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: DSImageView(source: DSAssets.vuesax.a3dCubeScanBold),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('You have pushed the button this many times:'),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            DSInput(
              controller: controller,
              title: 'Title',
              required: true,
              hint: 'Hint',
              enable: true,
              onTextChanged: (text, controller) {},
              prefixIcon: DSImageView(source: DSAssets.vuesax.a24SupportBold),
              suffixIcon: DSImageView(
                source: DSAssets.vuesax.alignBottomLinear,
              ),
            ),

            DSButton(
              key: Key('button'),
              variant: DSButtonVariants.primary,
              size: DSButtonSize.lg,
              label: 'Button',
              onPressed: () {},
              isDisabled: true,
              isLoading: true,
            ),
            const SizedBox(height: 20),
            Text(
              'Radio Buttons:',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 12),

            const SizedBox(height: 8),
            ImageViewWrapper.item(
              'https://hrmv0-files-dev.247tech.vn/companies/download/images-a748af894d00454f9b846ae2f4da41a5.jpg',
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}
