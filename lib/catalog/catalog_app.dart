import 'package:flutter/material.dart';

import '../theme/ds_theme.dart';
import 'tokens_showcase.dart';
import 'widget_demos.g.dart';

/// Catalog App - Main application to showcase all design system components
///
/// This app automatically loads all demo widgets and displays them in a organized list.
/// Each demo can be tapped to view the full component showcase.
class CatalogApp extends StatelessWidget {
  const CatalogApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Design System Catalog',
      theme: DSAppTheme.lightTheme,
      darkTheme: DSAppTheme.darkTheme,
      home: const CatalogHomePage(),
    );
  }
}

/// Home page of the catalog app
class CatalogHomePage extends StatelessWidget {
  const CatalogHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Design System Catalog'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        elevation: 2,
      ),
      body: Column(
        children: [
          // Header section
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primaryContainer,
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(16),
                bottomRight: Radius.circular(16),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Component Library',
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.onPrimaryContainer,
                      ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Explore and test all design system components',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: Theme.of(context).colorScheme.onPrimaryContainer,
                      ),
                ),
                const SizedBox(height: 16),
                Text(
                  '${demos.length} components available',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Theme.of(context)
                            .colorScheme
                            .onPrimaryContainer
                            .withOpacity(0.8),
                      ),
                ),
              ],
            ),
          ),

          // Components list
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                // Design Tokens Section
                _buildComponentCard(
                  context,
                  'Design Tokens',
                  'Colors, spacing, typography, and radius values',
                  Icons.palette,
                  () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const TokensShowcase(),
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                // Components Section
                const Text(
                  'Components',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),

                // Component demos
                ...demos.map(
                  (demo) => _buildComponentCard(
                    context,
                    demo.name,
                    _getComponentDescription(demo.name),
                    _getComponentIcon(demo.name),
                    () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DemoDetailPage(demo: demo),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildComponentCard(
    BuildContext context,
    String name,
    String description,
    IconData icon,
    VoidCallback onTap,
  ) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 2,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            children: [
              // Component icon
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primaryContainer,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  icon,
                  color: Theme.of(context).colorScheme.onPrimaryContainer,
                  size: 24,
                ),
              ),

              const SizedBox(width: 16),

              // Component info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      description,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color:
                                Theme.of(context).colorScheme.onSurfaceVariant,
                          ),
                    ),
                  ],
                ),
              ),

              // Arrow icon
              Icon(
                Icons.arrow_forward_ios,
                color: Theme.of(context).colorScheme.onSurfaceVariant,
                size: 16,
              ),
            ],
          ),
        ),
      ),
    );
  }

  IconData _getComponentIcon(String componentName) {
    switch (componentName.toLowerCase()) {
      case 'design tokens':
        return Icons.palette;
      case 'dsbutton':
        return Icons.touch_app;
      case 'loading':
        return Icons.refresh;
      case 'imageview':
        return Icons.image;
      default:
        return Icons.widgets;
    }
  }

  String _getComponentDescription(String componentName) {
    switch (componentName.toLowerCase()) {
      case 'design tokens':
        return 'Colors, spacing, typography, and radius values';
      case 'dsbutton':
        return 'Customizable button with multiple variants and states';
      case 'loading':
        return 'Loading indicator with different sizes and colors';
      case 'imageview':
        return 'Versatile image component supporting local, network, and SVG';
      default:
        return 'Design system component';
    }
  }
}

/// Detail page for individual component demo
class DemoDetailPage extends StatelessWidget {
  final WidgetDemo demo;

  const DemoDetailPage({
    super.key,
    required this.demo,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${demo.name} Demo'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: demo.demoWidget,
    );
  }
}
