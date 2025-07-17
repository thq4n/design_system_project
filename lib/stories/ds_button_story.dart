import 'package:flutter/material.dart';
import 'package:storybook_flutter/storybook_flutter.dart';
import '../components/ds_button/ds_button.dart';
import '../theme/ds_theme.dart';

/// DSButton Story for Storybook
///
/// This story showcases different variants and states of the DSButton component
/// using the storybook_flutter package for interactive component testing.
class DSButtonStory extends Story {
  DSButtonStory()
      : super(
          name: 'DSButton',
          description:
              '''A customizable button component with multiple variants, sizes, and states.''',
          builder: (context) => const DSButtonStoryWidget(),
        );
}

class DSButtonStoryWidget extends StatelessWidget {
  const DSButtonStoryWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final knobs = context.knobs;

    // Knobs for button configuration
    final label = knobs.text(
      label: 'Label',
      description: 'Button text label',
      initial: 'Click Me',
    );

    final isDisabled = knobs.boolean(
      label: 'Disabled',
      description: 'Whether the button is disabled',
      initial: false,
    );

    final isLoading = knobs.boolean(
      label: 'Loading',
      description: 'Whether to show loading state',
      initial: false,
    );

    final isActivated = knobs.boolean(
      label: 'Activated',
      description: 'Whether the button is in activated state',
      initial: false,
    );

    final showPrefixIcon = knobs.boolean(
      label: 'Show Prefix Icon',
      description: 'Whether to show an icon before the label',
      initial: false,
    );

    final showSuffixIcon = knobs.boolean(
      label: 'Show Suffix Icon',
      description: 'Whether to show an icon after the label',
      initial: false,
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('DSButton Story'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Interactive Button
            _buildSection(
              'Interactive Button',
              'Use the knobs above to customize this button',
              [
                Center(
                  child: DSButton(
                    label: label,
                    isDisabled: isDisabled,
                    isLoading: isLoading,
                    isActivated: isActivated,
                    prefixIcon: showPrefixIcon ? const Icon(Icons.add) : null,
                    suffixIcon:
                        showSuffixIcon ? const Icon(Icons.arrow_forward) : null,
                    onPressed: isDisabled || isLoading
                        ? null
                        : () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Button pressed: $label'),
                                duration: const Duration(seconds: 1),
                              ),
                            );
                          },
                  ),
                ),
              ],
            ),

            // All Variants
            _buildSection(
              'All Variants',
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
                  label: 'Outline Button',
                  variant: DSButtonVariants.outline,
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

            // All Sizes
            _buildSection(
              'All Sizes',
              'Different size presets for various contexts',
              [
                DSButton(
                  label: 'Extra Small',
                  size: DSButtonSize.xs,
                  onPressed: () {},
                ),
                const SizedBox(height: 12),
                DSButton(
                  label: 'Small',
                  size: DSButtonSize.sm,
                  onPressed: () {},
                ),
                const SizedBox(height: 12),
                DSButton(
                  label: 'Medium',
                  size: DSButtonSize.md,
                  onPressed: () {},
                ),
                const SizedBox(height: 12),
                DSButton(
                  label: 'Large',
                  size: DSButtonSize.lg,
                  onPressed: () {},
                ),
              ],
            ),

            // States
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

            // Icons
            _buildSection(
              'Buttons with Icons',
              'Buttons can include prefix and suffix icons',
              [
                DSButton(
                  label: 'Add Item',
                  prefixIcon: const Icon(Icons.add),
                  onPressed: () {},
                ),
                const SizedBox(height: 12),
                DSButton(
                  label: 'Continue',
                  suffixIcon: const Icon(Icons.arrow_forward),
                  onPressed: () {},
                ),
                const SizedBox(height: 12),
                DSButton(
                  label: 'Favorite',
                  prefixIcon: const Icon(Icons.favorite),
                  suffixIcon: const Icon(Icons.star),
                  onPressed: () {},
                ),
              ],
            ),
          ],
        ),
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
}
