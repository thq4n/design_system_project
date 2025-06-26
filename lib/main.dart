// lib/main.dart
import 'package:flutter/material.dart';

import 'theme/ds_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Design System Project',
      theme: DSAppTheme.lightTheme, // Sử dụng theme đã định nghĩa
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isDarkMode = false;

  late final Color seedColor = const Color(0xFF0057B7);

  late ThemeData lightTheme;
  late ThemeData darkTheme;
  @override
  void initState() {
    super.initState();
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   final RenderBox box =
    //       _bottomKey.currentContext?.findRenderObject() as RenderBox;
    //   setState(() {
    //     _bottomHeight = box.size.height;
    //   });
    // });

    lightTheme = ThemeData.from(
      colorScheme: DSColorScheme.lightScheme,
      useMaterial3: true,
    );
    darkTheme = ThemeData.from(
      colorScheme: DSColorScheme.darkScheme,
      useMaterial3: true,
    );
  }

  void toggleTheme() {
    setState(() {
      isDarkMode = !isDarkMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ColorScheme.fromSeed Demo',
      theme: isDarkMode ? darkTheme : lightTheme,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Design System Theme Demo'),
          actions: [
            IconButton(
              icon: Icon(
                isDarkMode ? Icons.wb_sunny_outlined : Icons.nightlight_round,
              ),
              onPressed: toggleTheme,
              tooltip:
                  isDarkMode ? 'Switch to Light Mode' : 'Switch to Dark Mode',
            ),
          ],
        ),
        body: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Text(
              'Primary Color',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 8),
            Container(
              height: 50,
              color: Theme.of(context).colorScheme.primary,
              alignment: Alignment.center,
              child: Text(
                'Primary',
                style:
                    TextStyle(color: Theme.of(context).colorScheme.onPrimary),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Secondary Color',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 8),
            Container(
              height: 50,
              color: Theme.of(context).colorScheme.secondary,
              alignment: Alignment.center,
              child: Text(
                'Secondary',
                style:
                    TextStyle(color: Theme.of(context).colorScheme.onSecondary),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Surface & Background',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 8),
            Card(
              color: Theme.of(context).colorScheme.surface,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Text(
                  'This is a Card with Surface color',
                  style:
                      TextStyle(color: Theme.of(context).colorScheme.onSurface),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Container(
              color: Theme.of(context).colorScheme.surface,
              padding: const EdgeInsets.all(16),
              child: Text(
                'Background color container',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {},
              child: const Text('Primary Button'),
            ),
            const SizedBox(height: 16),
            OutlinedButton(
              onPressed: () {},
              child: const Text('Secondary Button'),
            ),
            const SizedBox(height: 24),
            TextField(
              decoration: InputDecoration(
                labelText: 'Input Field',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            const SizedBox(height: 24),
            SwitchListTile(
              title: const Text('Toggle Switch'),
              value: isDarkMode,
              onChanged: (val) => toggleTheme(),
            ),
            const SizedBox(height: 24),
            CheckboxListTile(
              title: const Text('Checkbox'),
              value: true,
              onChanged: (_) {},
            ),
          ],
        ),
      ),
    );
  }
}
