import 'package:flutter/material.dart';
import 'package:design_system_project/design_system_project.dart';

class SimpleShimmerTest extends StatefulWidget {
  const SimpleShimmerTest({super.key});

  @override
  State<SimpleShimmerTest> createState() => _SimpleShimmerTestState();
}

class _SimpleShimmerTestState extends State<SimpleShimmerTest> {
  bool _isLoading = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Simple Shimmer Test'),
        backgroundColor: DSColorUsages.background.primary,
        foregroundColor: DSColorUsages.text.primary,
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
      body: Shimmer.withDefaultGradient(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // Basic shimmer loading
              ShimmerLoading(
                isLoading: _isLoading,
                child: Container(
                  height: 100,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: DSColorUsages.background.primary,
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Card skeleton
              ShimmerSkeleton(
                type: ShimmerSkeletonType.card,
                isLoading: _isLoading,
                child: Container(
                  height: 150,
                  decoration: BoxDecoration(
                    color: DSColorUsages.background.primary,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Center(child: Text('Card Content')),
                ),
              ),
              const SizedBox(height: 20),

              // List item skeleton
              ShimmerSkeleton(
                type: ShimmerSkeletonType.listItem,
                isLoading: _isLoading,
                child: Container(
                  height: 60,
                  decoration: BoxDecoration(
                    color: DSColorUsages.background.primary,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Center(child: Text('List Item')),
                ),
              ),
              const SizedBox(height: 20),

              // Button and chip skeletons
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
              const SizedBox(height: 20),

              // Progress skeleton
              ShimmerSkeleton(
                type: ShimmerSkeletonType.progress,
                isLoading: _isLoading,
                child: Container(
                  height: 40,
                  decoration: BoxDecoration(
                    color: DSColorUsages.background.primary,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Center(child: Text('Progress')),
                ),
              ),
              const SizedBox(height: 20),

              // Text skeleton
              ShimmerSkeleton(
                type: ShimmerSkeletonType.text,
                isLoading: _isLoading,
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: DSColorUsages.background.primary,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Text('Text Content'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
