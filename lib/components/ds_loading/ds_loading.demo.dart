import 'package:flutter/material.dart';
import 'ds_loading.dart';

/// Loading Demo Component
///
/// This demo showcases different configurations of the Loading component.
///
/// Customization Guide:
/// - Add more examples with different props combinations
/// - Update the description text to match your use cases
/// - Add real-world usage examples
/// - Customize the code examples below
class LoadingDemo extends StatelessWidget {
  const LoadingDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Loading Demo'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Description
            const Text(
              'Loading Component',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'A customizable loading indicator component with different sizes, colors, and brightness modes. '
              'Based on CupertinoActivityIndicator for consistent iOS-style loading animations.',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 24),

            // Default Loading
            _buildSection(
              'Default Loading',
              'Basic loading indicator with default settings',
              [
                const Loading(),
              ],
            ),

            // Different Sizes
            _buildSection(
              'Different Sizes',
              'Loading indicators with various radius values',
              [
                const Row(
                  children: [
                    Text('Small: '),
                    Loading(radius: 8),
                    SizedBox(width: 20),
                    Text('Medium: '),
                    Loading(radius: 15),
                    SizedBox(width: 20),
                    Text('Large: '),
                    Loading(radius: 25),
                  ],
                ),
              ],
            ),

            // Different Colors
            _buildSection(
              'Different Colors',
              'Loading indicators with custom colors',
              [
                const Row(
                  children: [
                    Text('Red: '),
                    Loading(color: Colors.red, radius: 15),
                    SizedBox(width: 20),
                    Text('Blue: '),
                    Loading(color: Colors.blue, radius: 15),
                    SizedBox(width: 20),
                    Text('Green: '),
                    Loading(color: Colors.green, radius: 15),
                  ],
                ),
              ],
            ),

            // Brightness Modes
            _buildSection(
              'Brightness Modes',
              'Loading indicators with different brightness settings',
              [
                Container(
                  padding: const EdgeInsets.all(16),
                  color: Colors.black,
                  child: const Row(
                    children: [
                      Text(
                        'Dark Mode: ',
                        style: TextStyle(color: Colors.white),
                      ),
                      Loading(brightness: Brightness.dark),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.all(16),
                  color: Colors.white,
                  child: const Row(
                    children: [
                      Text('Light Mode: '),
                      Loading(brightness: Brightness.light),
                    ],
                  ),
                ),
              ],
            ),

            // Usage Examples
            _buildSection(
              'Usage Examples',
              'Common use cases for loading indicators',
              [
                _buildUsageExample(
                  'Button Loading State',
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey[300]!),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Row(
                      children: [
                        Loading(radius: 12),
                        SizedBox(width: 12),
                        Text('Processing...'),
                      ],
                    ),
                  ),
                ),
                _buildUsageExample(
                  'Full Screen Loading',
                  Container(
                    height: 100,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey[300]!),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Center(
                      child: Loading(radius: 20),
                    ),
                  ),
                ),
              ],
            ),

            // Code Examples
            _buildCodeSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(
      String title, String description, List<Widget> children,) {
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

  Widget _buildUsageExample(String title, Widget example) {
    return Column(
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
        example,
        const SizedBox(height: 16),
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

        // Basic Loading
        _buildCodeExample(
          'Basic Loading',
          '''const Loading()''',
        ),

        // Loading with Custom Size
        _buildCodeExample(
          'Loading with Custom Size',
          '''const Loading(radius: 20)''',
        ),

        // Loading with Custom Color
        _buildCodeExample(
          'Loading with Custom Color',
          '''const Loading(
  radius: 15,
  color: Colors.blue,
)''',
        ),

        // Loading with Brightness
        _buildCodeExample(
          'Loading with Brightness',
          '''const Loading(
  radius: 15,
  brightness: Brightness.dark,
)''',
        ),

        // Loading in Button
        _buildCodeExample(
          'Loading in Button State',
          '''ElevatedButton(
  onPressed: isLoading ? null : () {},
  child: isLoading 
    ? const Loading(radius: 12)
    : const Text('Submit'),
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
