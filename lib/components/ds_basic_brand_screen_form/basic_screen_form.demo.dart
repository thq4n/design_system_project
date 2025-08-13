import 'package:flutter/material.dart';

import '../../base/ds_base.dart';
import '../../constants/constants.dart';
import '../../design_system_core/ds_color_usage/ds_color_usage_core.dart';
import '../../gen/assets.gen.dart';
import '../../theme/ds_theme.dart';
import '../ds_components.dart';

/// Demo page showing how to use the BasicScreenForm component.
class BasicScreenFormDemo extends StatefulWidget {
  const BasicScreenFormDemo({super.key});

  @override
  State<BasicScreenFormDemo> createState() => _BasicScreenFormDemoState();
}

class _BasicScreenFormDemoState extends DSStateBase<BasicScreenFormDemo> {
  @override
  Widget build(BuildContext context) {
    return DSBasicScreenForm(
      title: 'Basic Screen Form Demo',
      actions: [
        IconButton(
          onPressed: () {
            // Example action
          },
          icon: DSImageView(
            source: DSAssets.vuesax.moreCircleLinear,
            height: DSIconSizes.size24,
            width: DSIconSizes.size24,
            color: DSColorUsages.text.white,
          ),
        ),
      ],
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Example FAB action
        },
        child: DSImageView(
          source: DSAssets.vuesax.addLinear,
          height: DSIconSizes.size24,
          width: DSIconSizes.size24,
          color: DSColorUsages.text.white,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Welcome to BasicScreenForm Demo',
              style: textTheme.xl?.bold,
            ),
            const SizedBox(height: 16),
            Text(
              'This is a simple screen form component that provides:',
              style: textTheme.base?.medium,
            ),
            const SizedBox(height: 8),
            _buildFeatureItem('• Modern blur effect app bar'),
            _buildFeatureItem('• App bar with title and back button'),
            _buildFeatureItem('• Customizable colors and styling'),
            _buildFeatureItem('• Action buttons support'),
            _buildFeatureItem('• Floating action button support'),
            _buildFeatureItem('• Bottom navigation bar support'),
            _buildFeatureItem('• Automatic keyboard dismissal'),
            _buildFeatureItem('• Smart back button handling'),
            _buildFeatureItem('• Custom padding support'),
            const SizedBox(height: 24),
            _buildExampleSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildFeatureItem(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Text(
        text,
        style: textTheme.sm?.regular,
      ),
    );
  }

  Widget _buildExampleSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Customization Examples:',
          style: textTheme.lg?.semibold,
        ),
        const SizedBox(height: 16),
        _buildCustomizationExample(
          'Blur Effect',
          'Modern blur effect app bar with customizable opacity',
          () => const DSBasicScreenForm(
            title: 'Blur Effect Demo',
            enableBlur: true,
            maxBlurOpacity: 0.8,
            child: Center(
              child: Text('Modern blur effect app bar'),
            ),
          ),
        ),
        const SizedBox(height: 16),
        _buildCustomizationExample(
          'Custom Colors',
          'You can customize app bar and background colors',
          () => DSBasicScreenForm(
            title: 'Custom Colors',
            appbarColor: DSColorUsages.background.brandSecondary,
            backgroundColor: DSColorUsages.background.primary,
            child: const Center(
              child: Text('Custom colored form'),
            ),
          ),
        ),
        const SizedBox(height: 16),
        _buildCustomizationExample(
          'No Back Button',
          'Hide the back button when not needed',
          () => const DSBasicScreenForm(
            title: 'No Back Button',
            showBackButton: false,
            child: Center(
              child: Text('Form without back button'),
            ),
          ),
        ),
        const SizedBox(height: 16),
        _buildCustomizationExample(
          'Custom Title Style',
          'Apply custom text styling to the title',
          () => DSBasicScreenForm(
            title: 'Custom Title Style',
            titleStyle: textTheme.xl?.bold.copyWithColor(
              DSColorUsages.text.secondary,
            ),
            child: const Center(
              child: Text('Form with custom title style'),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCustomizationExample(
    String title,
    String description,
    Widget Function() formBuilder,
  ) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: textTheme.base?.semibold,
            ),
            const SizedBox(height: 4),
            Text(
              description,
              style: textTheme.sm?.regular.copyWithColor(
                DSColorUsages.text.secondary,
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // Navigate to example
                },
                child: const Text('View Example'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
