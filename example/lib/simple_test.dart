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
      body: Shimmer(
        linearGradient: const LinearGradient(
          colors: [Color(0xFFEBEBF4), Color(0xFFF4F4F4), Color(0xFFEBEBF4)],
          stops: [0.1, 0.3, 0.4],
          begin: Alignment(-1.0, -0.3),
          end: Alignment(1.0, 0.3),
          tileMode: TileMode.clamp,
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
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
