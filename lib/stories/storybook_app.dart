import 'package:flutter/material.dart';
import 'package:storybook_flutter/storybook_flutter.dart';
import '../theme/ds_theme.dart';
import 'ds_button_story.dart';

/// Storybook App - Main application for component stories
///
/// This app provides an organized way to browse and test all component stories.
/// Each story showcases different aspects and configurations of design system components.
class StorybookApp extends StatelessWidget {
  const StorybookApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Design System Storybook',
      theme: DSAppTheme.lightTheme,
      darkTheme: DSAppTheme.darkTheme,
      home: Storybook(
        wrapperBuilder: (context, child) => MaterialApp(
          title: 'Design System Storybook',
          theme: DSAppTheme.lightTheme,
          darkTheme: DSAppTheme.darkTheme,
          home: child,
        ),
        stories: [
          DSButtonStory(),
          // Add more stories here as you create them
        ],
        initialStory: 'DSButton',
      ),
    );
  }
}
