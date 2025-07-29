import 'package:flutter/material.dart';
import 'package:design_system_project/design_system_project.dart';

class TestShimmerPage extends StatefulWidget {
  const TestShimmerPage({super.key});

  @override
  State<TestShimmerPage> createState() => _TestShimmerPageState();
}

class _TestShimmerPageState extends State<TestShimmerPage> {
  bool _isLoading = true;

  static const LinearGradient _shimmerGradient = LinearGradient(
    colors: [Color(0xFFEBEBF4), Color(0xFFF4F4F4), Color(0xFFEBEBF4)],
    stops: [0.1, 0.3, 0.4],
    begin: Alignment(-1.0, -0.3),
    end: Alignment(1.0, 0.3),
    tileMode: TileMode.clamp,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Test Shimmer'),
        actions: [
          IconButton(
            icon: Icon(_isLoading ? Icons.stop : Icons.play_arrow),
            onPressed: () {
              setState(() {
                _isLoading = !_isLoading;
              });
            },
          ),
        ],
      ),
      body: Shimmer(
        linearGradient: _shimmerGradient,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // Test basic shimmer loading
              ShimmerLoading(
                isLoading: _isLoading,
                child: Container(
                  height: 100,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Test shimmer skeleton
              ShimmerSkeleton(
                type: ShimmerSkeletonType.card,
                isLoading: _isLoading,
                child: Container(
                  height: 150,
                  decoration: BoxDecoration(
                    color: Colors.blue[100],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Center(child: Text('Card Content')),
                ),
              ),
              const SizedBox(height: 20),

              // Test multiple items
              ShimmerLoading(
                isLoading: _isLoading,
                child: Container(
                  height: 60,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              ShimmerLoading(
                isLoading: _isLoading,
                child: Container(
                  height: 60,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
