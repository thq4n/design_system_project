import 'package:flutter/material.dart';

import '../base/ds_base.dart';

/// Design Tokens Showcase
///
/// This component displays all design system tokens including colors, spacing,
/// typography, and radius values in an organized and visual way.
class TokensShowcase extends StatefulWidget {
  const TokensShowcase({super.key});

  @override
  State<TokensShowcase> createState() => _TokensShowcaseState();
}

class _TokensShowcaseState extends DSStateBase<TokensShowcase> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Design Tokens'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            const Text(
              'Design System Tokens',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              '''Core design tokens that define the visual language of the design system.''',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 32),

            // Colors Section
            _buildColorsSection(),

            const SizedBox(height: 32),

            // Spacing Section
            _buildSpacingSection(),

            const SizedBox(height: 32),

            // Typography Section
            _buildTypographySection(),

            const SizedBox(height: 32),

            // Radius Section
            _buildRadiusSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildColorsSection() {
    return _buildSection(
      'Colors',
      'Color palette used throughout the design system',
      [
        _buildColorCategory('Brand Colors', [
          _buildColorItem('Primary', Colors.red),
          _buildColorItem('Secondary', Colors.blue),
        ]),
        const SizedBox(height: 16),
        _buildColorCategory('Text Colors', [
          _buildColorItem('Primary', Colors.black87),
          _buildColorItem('Secondary', Colors.black54),
          _buildColorItem('Disabled', Colors.grey),
          _buildColorItem('White', Colors.white),
        ]),
        const SizedBox(height: 16),
        _buildColorCategory('Background Colors', [
          _buildColorItem('Primary', Colors.white),
          _buildColorItem('Secondary', Colors.grey[100]!),
          _buildColorItem('Disable', Colors.grey[300]!),
        ]),
        const SizedBox(height: 16),
        _buildColorCategory('Icon Colors', [
          _buildColorItem('Primary', Colors.black87),
          _buildColorItem('Secondary', Colors.black54),
          _buildColorItem('Disable', Colors.grey),
          _buildColorItem('White', Colors.white),
        ]),
      ],
    );
  }

  Widget _buildColorCategory(String title, List<Widget> children) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        ...children,
      ],
    );
  }

  Widget _buildColorItem(String name, Color color) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[300]!),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.grey[300]!),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '''#${color.toARGB32().toRadixString(16).substring(2).toUpperCase()}''',
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                    fontFamily: 'monospace',
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSpacingSection() {
    return _buildSection(
      'Spacing',
      'Consistent spacing values used for margins and padding',
      [
        DataTable(
          columns: const [
            DataColumn(label: Text('Name')),
            DataColumn(label: Text('Value')),
            DataColumn(label: Text('Preview')),
          ],
          rows: [
            _buildSpacingRow('xs', 4),
            _buildSpacingRow('sm', 8),
            _buildSpacingRow('md', 16),
            _buildSpacingRow('lg', 24),
            _buildSpacingRow('xl', 32),
            _buildSpacingRow('xxl', 48),
          ],
        ),
      ],
    );
  }

  DataRow _buildSpacingRow(String name, double value) {
    return DataRow(
      cells: [
        DataCell(Text(name)),
        DataCell(Text('${value.toInt()}px')),
        DataCell(
          Container(
            width: value,
            height: 20,
            decoration: BoxDecoration(
              color: Colors.blue[100],
              borderRadius: BorderRadius.circular(4),
            ),
            child: Center(
              child: Text(
                '${value.toInt()}',
                style: const TextStyle(fontSize: 10),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTypographySection() {
    return _buildSection(
      'Typography',
      'Font sizes and weights used for text elements',
      [
        _buildTypographyCategory('Font Sizes', [
          _buildTypographyItem('xs', 12),
          _buildTypographyItem('sm', 14),
          _buildTypographyItem('md', 16),
          _buildTypographyItem('lg', 18),
          _buildTypographyItem('xl', 24),
          _buildTypographyItem('xxl', 32),
        ]),
        const SizedBox(height: 24),
        _buildTypographyCategory('Font Weights', [
          _buildFontWeightItem('Light', FontWeight.w300),
          _buildFontWeightItem('Regular', FontWeight.w400),
          _buildFontWeightItem('Medium', FontWeight.w500),
          _buildFontWeightItem('SemiBold', FontWeight.w600),
          _buildFontWeightItem('Bold', FontWeight.w700),
        ]),
      ],
    );
  }

  Widget _buildTypographyCategory(String title, List<Widget> children) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        ...children,
      ],
    );
  }

  Widget _buildTypographyItem(String name, double size) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[300]!),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              'Sample Text',
              style: TextStyle(fontSize: size),
            ),
          ),
          const SizedBox(width: 12),
          Text(
            '${size.toInt()}px',
            style: const TextStyle(
              fontSize: 12,
              color: Colors.grey,
              fontFamily: 'monospace',
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFontWeightItem(String name, FontWeight weight) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[300]!),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              'Sample Text',
              style: TextStyle(fontWeight: weight),
            ),
          ),
          const SizedBox(width: 12),
          Text(
            name,
            style: const TextStyle(
              fontSize: 12,
              color: Colors.grey,
              fontFamily: 'monospace',
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRadiusSection() {
    return _buildSection(
      'Border Radius',
      'Border radius values for rounded corners',
      [
        DataTable(
          columns: const [
            DataColumn(label: Text('Name')),
            DataColumn(label: Text('Value')),
            DataColumn(label: Text('Preview')),
          ],
          rows: [
            _buildRadiusRow('xs', 4),
            _buildRadiusRow('sm', 8),
            _buildRadiusRow('md', 12),
            _buildRadiusRow('lg', 16),
            _buildRadiusRow('xl', 24),
            _buildRadiusRow('xxl', 32),
          ],
        ),
      ],
    );
  }

  DataRow _buildRadiusRow(String name, double value) {
    return DataRow(
      cells: [
        DataCell(Text(name)),
        DataCell(Text('${value.toInt()}px')),
        DataCell(
          Container(
            width: 60,
            height: 40,
            decoration: BoxDecoration(
              color: Colors.green[100],
              borderRadius: BorderRadius.circular(value),
            ),
            child: Center(
              child: Text(
                '${value.toInt()}',
                style: const TextStyle(fontSize: 10),
              ),
            ),
          ),
        ),
      ],
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
        Text(
          title,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          description,
          style: const TextStyle(
            fontSize: 16,
            color: Colors.grey,
          ),
        ),
        const SizedBox(height: 16),
        ...children,
      ],
    );
  }
}
