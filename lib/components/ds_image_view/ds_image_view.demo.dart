import 'package:flutter/material.dart';
import 'ds_image_view.dart';

/// ImageView Demo Component
///
/// This demo showcases different configurations of the ImageView component.
///
/// Customization Guide:
/// - Add more examples with different props combinations
/// - Update the description text to match your use cases
/// - Add real-world usage examples
/// - Customize the code examples below
class ImageViewDemo extends StatelessWidget {
  const ImageViewDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Description
          const Text(
            'ImageView Component',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            '''A versatile image component that supports local assets, network images, and SVG files. '''
            '''Includes built-in loading states, error handling, and placeholder support.''',
            style: TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 24),

          // Basic Usage
          _buildSection(
            'Basic Usage',
            'Simple image display with default settings',
            [
              const ImageView(
                source: 'assets/branding/ic_logo_full_red.png',
                width: 200,
                height: 100,
              ),
            ],
          ),

          // Different Sizes
          _buildSection(
            'Different Sizes',
            'Images with various dimensions',
            [
              const Row(
                children: [
                  ImageView(
                    source: 'assets/branding/ic_logo_alone_red.png',
                    width: 50,
                    height: 50,
                  ),
                  SizedBox(width: 16),
                  ImageView(
                    source: 'assets/branding/ic_logo_alone_red.png',
                    width: 100,
                    height: 100,
                  ),
                  SizedBox(width: 16),
                  ImageView(
                    source: 'assets/branding/ic_logo_alone_red.png',
                    width: 150,
                    height: 150,
                  ),
                ],
              ),
            ],
          ),

          // Different Fit Modes
          _buildSection(
            'Different Fit Modes',
            'Images with various BoxFit options',
            [
              _buildFitExample('cover', BoxFit.cover),
              const SizedBox(height: 16),
              _buildFitExample('contain', BoxFit.contain),
              const SizedBox(height: 16),
              _buildFitExample('fill', BoxFit.fill),
            ],
          ),

          // Network Images
          _buildSection(
            'Network Images',
            'Loading images from URLs with built-in loading states',
            [
              const ImageView(
                source: 'https://picsum.photos/200/100',
                width: 200,
                height: 100,
              ),
              const SizedBox(height: 16),
              const ImageView(
                source: 'https://picsum.photos/200/100?random=1',
                width: 200,
                height: 100,
                fit: BoxFit.cover,
              ),
            ],
          ),

          // SVG Images
          _buildSection(
            'SVG Images',
            'Vector graphics with color customization',
            [
              const Row(
                children: [
                  ImageView(
                    source: 'assets/social/ic_apple_original.svg',
                    width: 50,
                    height: 50,
                  ),
                  SizedBox(width: 16),
                  ImageView(
                    source: 'assets/social/ic_apple_original.svg',
                    width: 50,
                    height: 50,
                    color: Colors.blue,
                  ),
                  SizedBox(width: 16),
                  ImageView(
                    source: 'assets/social/ic_apple_original.svg',
                    width: 50,
                    height: 50,
                    color: Colors.green,
                  ),
                ],
              ),
            ],
          ),

          // Error Handling
          _buildSection(
            'Error Handling',
            'Images with fallback placeholders',
            [
              const ImageView(
                source: 'https://invalid-url-that-will-fail.com/image.jpg',
                width: 200,
                height: 100,
                placeHolder: 'assets/branding/ic_logo_alone_red.png',
              ),
            ],
          ),

          // Custom Loading
          _buildSection(
            'Custom Loading',
            'Images with custom loading radius',
            [
              const ImageView(
                source: 'https://picsum.photos/200/100?random=2',
                width: 200,
                height: 100,
                loadingRadius: 8,
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

  Widget _buildFitExample(String title, BoxFit fit) {
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
        Container(
          width: 200,
          height: 100,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey[300]!),
          ),
          child: const ImageView(
            source: 'assets/branding/ic_logo_alone_red.png',
            width: 200,
            height: 100,
            fit: BoxFit.cover, // This will be overridden by the parameter
          ),
        ),
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

        // Basic Image
        _buildCodeExample(
          'Basic Image',
          '''const ImageView(
  source: 'assets/branding/ic_logo_full_red.png',
  width: 200,
  height: 100,
)''',
        ),

        // Network Image
        _buildCodeExample(
          'Network Image',
          '''const ImageView(
  source: 'https://picsum.photos/200/100',
  width: 200,
  height: 100,
  fit: BoxFit.cover,
)''',
        ),

        // SVG with Color
        _buildCodeExample(
          'SVG with Color',
          '''const ImageView(
  source: 'assets/social/ic_apple_original.svg',
  width: 50,
  height: 50,
  color: Colors.blue,
)''',
        ),

        // Image with Placeholder
        _buildCodeExample(
          'Image with Placeholder',
          '''const ImageView(
  source: 'https://example.com/image.jpg',
  width: 200,
  height: 100,
  placeHolder: 'assets/branding/ic_logo_alone_red.png',
)''',
        ),

        // Custom Loading
        _buildCodeExample(
          'Custom Loading',
          '''const ImageView(
  source: 'https://picsum.photos/200/100',
  width: 200,
  height: 100,
  loadingRadius: 8,
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
