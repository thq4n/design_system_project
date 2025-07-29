import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:design_system_project/design_system_project.dart';

void main() {
  group('Shimmer Animation Tests', () {
    testWidgets('Shimmer animation should work without errors',
        (WidgetTester tester) async {
      // Build the shimmer widget
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Shimmer.withDefaultGradient(
              child: ShimmerLoading(
                isLoading: true,
                child: Container(
                  height: 100,
                  width: 200,
                  color: Colors.grey[300],
                ),
              ),
            ),
          ),
        ),
      );

      // Wait for the animation to start
      await tester.pump();

      // Verify no errors occurred during animation
      expect(tester.takeException(), isNull);

      // Pump multiple frames to test animation
      for (int i = 0; i < 10; i++) {
        await tester.pump(const Duration(milliseconds: 100));
        expect(tester.takeException(), isNull);
      }
    });

    testWidgets('Shimmer skeleton should work without errors',
        (WidgetTester tester) async {
      // Build the shimmer skeleton widget
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Shimmer.withDefaultGradient(
              child: ShimmerSkeleton(
                type: ShimmerSkeletonType.card,
                isLoading: true,
                child: Container(
                  height: 200,
                  width: 300,
                  color: Colors.grey[300],
                ),
              ),
            ),
          ),
        ),
      );

      // Wait for the animation to start
      await tester.pump();

      // Verify no errors occurred during animation
      expect(tester.takeException(), isNull);

      // Pump multiple frames to test animation
      for (int i = 0; i < 10; i++) {
        await tester.pump(const Duration(milliseconds: 100));
        expect(tester.takeException(), isNull);
      }
    });

    testWidgets('Shimmer should handle loading state changes',
        (WidgetTester tester) async {
      bool isLoading = true;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Shimmer.withDefaultGradient(
              child: ShimmerLoading(
                isLoading: isLoading,
                child: Container(
                  height: 100,
                  width: 200,
                  color: Colors.grey[300],
                ),
              ),
            ),
          ),
        ),
      );

      // Test loading state
      await tester.pump();
      expect(tester.takeException(), isNull);

      // Change to not loading
      isLoading = false;
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Shimmer.withDefaultGradient(
              child: ShimmerLoading(
                isLoading: isLoading,
                child: Container(
                  height: 100,
                  width: 200,
                  color: Colors.grey[300],
                ),
              ),
            ),
          ),
        ),
      );

      await tester.pump();
      expect(tester.takeException(), isNull);
    });

    testWidgets('All shimmer skeleton types should work without errors',
        (WidgetTester tester) async {
      const skeletonTypes = ShimmerSkeletonType.values;

      for (final type in skeletonTypes) {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: Shimmer.withDefaultGradient(
                child: ShimmerSkeleton(
                  type: type,
                  isLoading: true,
                  child: Container(
                    height: 100,
                    width: 200,
                    color: Colors.grey[300],
                  ),
                ),
              ),
            ),
          ),
        );

        await tester.pump();
        expect(tester.takeException(), isNull,
            reason: 'Error with skeleton type: $type');

        // Pump a few more frames
        for (int i = 0; i < 5; i++) {
          await tester.pump(const Duration(milliseconds: 100));
          expect(tester.takeException(), isNull,
              reason: 'Error with skeleton type: $type at frame $i');
        }
      }
    });

    testWidgets('Different gradient types should work without errors',
        (WidgetTester tester) async {
      final gradientBuilders = [
        () => Shimmer.withDefaultGradient(child: Container()),
        () => Shimmer.withLightGradient(child: Container()),
        () => Shimmer.withMediumGradient(child: Container()),
        () => Shimmer.withDarkGradient(child: Container()),
        () => Shimmer.withBrandGradient(child: Container()),
        () => Shimmer.withRainbowGradient(child: Container()),
        () => Shimmer.withPulseEffect(child: Container()),
        () => Shimmer.withWaveEffect(child: Container()),
      ];

      for (int i = 0; i < gradientBuilders.length; i++) {
        final builder = gradientBuilders[i];

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: builder(),
            ),
          ),
        );

        await tester.pump();
        expect(tester.takeException(), isNull,
            reason: 'Error with gradient builder $i');

        // Pump a few more frames
        for (int j = 0; j < 3; j++) {
          await tester.pump(const Duration(milliseconds: 100));
          expect(tester.takeException(), isNull,
              reason: 'Error with gradient builder $i at frame $j');
        }
      }
    });
  });
}
