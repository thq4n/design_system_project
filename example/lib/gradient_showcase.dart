import 'package:flutter/material.dart';
import 'package:design_system_project/design_system_project.dart';

class GradientShowcase extends StatefulWidget {
  const GradientShowcase({super.key});

  @override
  State<GradientShowcase> createState() => _GradientShowcaseState();
}

class _GradientShowcaseState extends State<GradientShowcase> {
  bool _isLoading = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Enhanced Shimmer Showcase'),
        actions: [
          TextButton(
            onPressed: () {
              setState(() {
                _isLoading = !_isLoading;
              });
            },
            child: Text(_isLoading ? 'Stop' : 'Start'),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          _buildGradientSection(
            'Default Gradient (Design System Gray)',
            'Subtle effect using gray.shape100 and gray.shape200',
            Shimmer.withDefaultGradient(child: _buildTestItems()),
          ),
          const SizedBox(height: 24),

          _buildGradientSection(
            'Light Gradient (Very Subtle)',
            'Very subtle effect using gray.shape50 and gray.shape100',
            Shimmer.withLightGradient(child: _buildTestItems()),
          ),
          const SizedBox(height: 24),

          _buildGradientSection(
            'Medium Gradient (Standard)',
            'Standard effect using gray.shape200 and gray.shape300',
            Shimmer.withMediumGradient(child: _buildTestItems()),
          ),
          const SizedBox(height: 24),

          _buildGradientSection(
            'Dark Gradient (Strong Effect)',
            'Strong effect using gray.shape300 and gray.shape400',
            Shimmer.withDarkGradient(child: _buildTestItems()),
          ),
          const SizedBox(height: 24),

          _buildGradientSection(
            'Brand Gradient (Brand Colors)',
            'Brand effect using brand.shape100 and brand.shape200',
            Shimmer.withBrandGradient(child: _buildTestItems()),
          ),
          const SizedBox(height: 24),

          _buildGradientSection(
            'Rainbow Gradient (Colorful Effect)',
            'Colorful effect with brand and gray colors',
            Shimmer.withRainbowGradient(child: _buildTestItems()),
          ),
          const SizedBox(height: 24),

          _buildGradientSection(
            'Pulse Effect (Dynamic)',
            'Pulsing effect with multiple color stops',
            Shimmer.withPulseEffect(child: _buildTestItems()),
          ),
          const SizedBox(height: 24),

          _buildGradientSection(
            'Wave Effect (Smooth)',
            'Smooth wave-like effect',
            Shimmer.withWaveEffect(child: _buildTestItems()),
          ),
          const SizedBox(height: 24),

          _buildGradientSection(
            'Custom Gradient',
            'Custom gradient with specific colors',
            Shimmer(
              linearGradient: const LinearGradient(
                colors: [
                  Color(0xFFE5E5E5),
                  Color(0xFFD4D4D4),
                  Color(0xFFE5E5E5),
                ],
                stops: [0.1, 0.3, 0.4],
                begin: Alignment(-1.0, -0.3),
                end: Alignment(1.0, 0.3),
                tileMode: TileMode.clamp,
              ),
              child: _buildTestItems(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGradientSection(
    String title,
    String description,
    Widget shimmerWidget,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 4),
        Text(
          description,
          style: TextStyle(fontSize: 14, color: Colors.grey[600]),
        ),
        const SizedBox(height: 12),
        shimmerWidget,
      ],
    );
  }

  Widget _buildTestItems() {
    return Column(
      children: [
        // Enhanced card skeleton
        ShimmerSkeleton(
          type: ShimmerSkeletonType.card,
          isLoading: _isLoading,
          child: Container(
            height: 120,
            decoration: BoxDecoration(
              color: DSColorUsages.background.primary,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Center(child: Text('Enhanced Card')),
          ),
        ),
        const SizedBox(height: 12),

        // Enhanced list item skeleton
        ShimmerSkeleton(
          type: ShimmerSkeletonType.listItem,
          isLoading: _isLoading,
          child: Container(
            height: 60,
            decoration: BoxDecoration(
              color: DSColorUsages.background.primary,
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Center(child: Text('Enhanced List Item')),
          ),
        ),
        const SizedBox(height: 12),

        // New skeleton types
        Row(
          children: [
            Expanded(
              child: ShimmerSkeleton(
                type: ShimmerSkeletonType.button,
                isLoading: _isLoading,
                child: Container(
                  height: 48,
                  decoration: BoxDecoration(
                    color: DSColorUsages.background.primary,
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: const Center(child: Text('Button')),
                ),
              ),
            ),
            const SizedBox(width: 12),
            ShimmerSkeleton(
              type: ShimmerSkeletonType.chip,
              isLoading: _isLoading,
              child: Container(
                height: 32,
                width: 80,
                decoration: BoxDecoration(
                  color: DSColorUsages.background.primary,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Center(child: Text('Chip')),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),

        // Progress skeleton
        ShimmerSkeleton(
          type: ShimmerSkeletonType.progress,
          isLoading: _isLoading,
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: DSColorUsages.background.primary,
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Text('Progress Bar'),
          ),
        ),
        const SizedBox(height: 12),

        // Avatar and text skeleton
        Row(
          children: [
            ShimmerSkeleton(
              type: ShimmerSkeletonType.avatar,
              isLoading: _isLoading,
              child: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: DSColorUsages.background.primary,
                  shape: BoxShape.circle,
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: ShimmerSkeleton(
                type: ShimmerSkeletonType.text,
                isLoading: _isLoading,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 12,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: DSColorUsages.background.primary,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    const SizedBox(height: 6),
                    Container(
                      height: 12,
                      width: 150,
                      decoration: BoxDecoration(
                        color: DSColorUsages.background.primary,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
