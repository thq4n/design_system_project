import 'package:flutter/material.dart';

import '../../theme/ds_theme.dart';
import 'ds_button.dart';

/// DSButton Demo Component
///
/// This demo showcases different variants and states of the DSButton component.
///
/// Customization Guide:
/// - Add more examples with different props combinations
/// - Update the description text to match your use cases
/// - Add real-world usage examples
/// - Customize the code examples below
class DSButtonDemo extends StatelessWidget {
  const DSButtonDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Description
          const Text(
            'DSButton Component',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            '''A customizable button component with multiple variants, sizes, and states. '''
            'Supports icons, loading states, and different visual styles.',
            style: TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 24),

          // Variants Section
          _buildSection(
            'Button Variants',
            'Different visual styles for different use cases',
            [
              DSButton(
                label: 'Primary Button',
                onPressed: () {},
              ),
              const SizedBox(height: 12),
              DSButton(
                label: 'Secondary Button',
                variant: DSButtonVariants.secondary,
                onPressed: () {},
              ),
              const SizedBox(height: 12),
              DSButton(
                label: 'Ghost Button',
                variant: DSButtonVariants.ghost,
                onPressed: () {},
              ),
            ],
          ),

          // Sizes Section
          _buildSection(
            'Button Sizes',
            'Different size presets for various contexts',
            [
              DSButton(
                label: 'Small Button',
                size: DSButtonSize.sm,
                onPressed: () {},
              ),
              const SizedBox(height: 12),
              DSButton(
                label: 'Medium Button',
                size: DSButtonSize.md,
                onPressed: () {},
              ),
              const SizedBox(height: 12),
              DSButton(
                label: 'Large Button',
                size: DSButtonSize.lg,
                onPressed: () {},
              ),
            ],
          ),

          // States Section
          _buildSection(
            'Button States',
            'Different interactive states',
            [
              DSButton(
                label: 'Normal Button',
                onPressed: () {},
              ),
              const SizedBox(height: 12),
              DSButton(
                label: 'Disabled Button',
                isDisabled: true,
                onPressed: () {},
              ),
              const SizedBox(height: 12),
              DSButton(
                label: 'Loading Button',
                isLoading: true,
                onPressed: () {},
              ),
              const SizedBox(height: 12),
              DSButton(
                label: 'Activated Button',
                isActivated: true,
                onPressed: () {},
              ),
            ],
          ),

          // Icons Section
          _buildSection(
            'Buttons with Icons',
            'Buttons can include prefix and suffix icons',
            [
              DSButton(
                label: 'Button with Icon',
                prefixIcon: Icons.add,
                onPressed: () {},
              ),
              const SizedBox(height: 12),
              DSButton(
                label: 'Button with Suffix',
                suffixIcon: Icons.arrow_forward,
                onPressed: () {},
              ),
              const SizedBox(height: 12),
              DSButton(
                label: 'Icon Only',
                prefixIcon: Icons.favorite,
                onPressed: () {},
              ),
            ],
          ),

          // Code Examples
          _buildCodeSection(),
        ],
      ),
    );
  }

  Widget _buildSection(
    String title,
    String description,
    List<Widget> children,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 32),
        Text(
          title,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          description,
          style: const TextStyle(
            fontSize: 14,
            color: Colors.grey,
          ),
        ),
        const SizedBox(height: 16),
        ...children,
      ],
    );
  }

  Widget _buildCodeSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 32),
        const Text(
          'Code Examples',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),

        // Basic Button
        _buildCodeExample(
          'Basic Button',
          '''DSButton(
  label: 'Click Me',
  onPressed: () {
    // Handle button press
  },
)''',
        ),

        // Button with Variant
        _buildCodeExample(
          'Button with Variant',
          '''DSButton(
  label: 'Secondary Button',
  variant: DSButtonVariants.secondary,
  onPressed: () {},
)''',
        ),

        // Button with Icon
        _buildCodeExample(
          'Button with Icon',
          '''DSButton(
  label: 'Add Item',
  prefixIcon: Icons.add,
  onPressed: () {},
)''',
        ),

        // Loading Button
        _buildCodeExample(
          'Loading Button',
          '''DSButton(
  label: 'Processing...',
  isLoading: true,
  onPressed: () {},
)''',
        ),
      ],
    );
  }

  Widget _buildCodeExample(String title, String code) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 8),
          SelectableText(
            code,
            style: const TextStyle(
              fontFamily: 'monospace',
              fontSize: 12,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }
}
