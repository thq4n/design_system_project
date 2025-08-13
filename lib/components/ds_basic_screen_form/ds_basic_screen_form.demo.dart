import 'package:flutter/material.dart';

import '../../base/ds_base.dart';
import '../../constants/constants.dart';
import '../../design_system_core/ds_color_usage/ds_color_usage_core.dart';
import '../../gen/assets.gen.dart';
import '../../theme/ds_theme.dart';
import '../ds_components.dart';

/// Demo page showing how to use the DSBasicScreenForm component with its
/// dedicated theme.
class DSBasicScreenFormDemo extends StatefulWidget {
  const DSBasicScreenFormDemo({super.key});

  @override
  State<DSBasicScreenFormDemo> createState() => _DSBasicScreenFormDemoState();
}

class _DSBasicScreenFormDemoState extends DSStateBase<DSBasicScreenFormDemo> {
  @override
  Widget build(BuildContext context) {
    return DSBasicScreenForm(
      title: 'DSBasicScreenForm Demo',
      actions: [
        IconButton(
          onPressed: () {
            // Handle menu action
          },
          icon: DSImageView(
            source: DSAssets.vuesax.moreCircleLinear,
            height: DSIconSizes.size24,
            width: DSIconSizes.size24,
            color: DSColorUsages.text.white,
          ),
        ),
      ],
      child: _buildContent(),
    );
  }

  Widget _buildContent() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionTitle('Dedicated Theme'),
          const SizedBox(height: 8),
          Text(
            'This component now uses its own dedicated theme instead of '
            'sharing with DSBasicBrandScreenForm.',
            style: textTheme.sm?.regular.copyWithColor(
              DSColorUsages.text.secondary,
            ),
          ),
          const SizedBox(height: 24),
          _buildSectionTitle('Features'),
          const SizedBox(height: 8),
          _buildFeatureItem('✅ Blur effect app bar'),
          _buildFeatureItem('✅ Customizable blur opacity'),
          _buildFeatureItem('✅ Dedicated theme configuration'),
          _buildFeatureItem('✅ Independent from brand screen form'),
          const SizedBox(height: 24),
          _buildSectionTitle('Theme Properties'),
          const SizedBox(height: 8),
          _buildThemeProperty('showBackButton', 'true'),
          _buildThemeProperty('centerTitle', 'true'),
          _buildThemeProperty('enableBlur', 'true'),
          _buildThemeProperty('maxBlurOpacity', '0.7'),
          const SizedBox(height: 24),
          _buildSectionTitle('Customization Examples'),
          const SizedBox(height: 16),
          _buildCustomizationExample(
            'Custom Blur Opacity',
            'Adjust the blur effect intensity',
            () => const DSBasicScreenForm(
              title: 'High Blur Demo',
              maxBlurOpacity: 0.9,
              child: Center(
                child: Text('Stronger blur effect'),
              ),
            ),
          ),
          const SizedBox(height: 16),
          _buildCustomizationExample(
            'Custom Colors',
            'Override theme colors',
            () => DSBasicScreenForm(
              title: 'Custom Colors',
              appbarColor: DSColorUsages.background.brandSecondary,
              backgroundColor: DSColorUsages.background.primary,
              child: const Center(
                child: Text('Custom colored form'),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: textTheme.lg?.semibold,
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

  Widget _buildThemeProperty(String property, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        children: [
          Text(
            '$property: ',
            style: textTheme.sm?.semibold,
          ),
          Text(
            value,
            style: textTheme.sm?.regular.copyWithColor(
              DSColorUsages.text.secondary,
            ),
          ),
        ],
      ),
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
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => Scaffold(
                        body: formBuilder(),
                      ),
                    ),
                  );
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
