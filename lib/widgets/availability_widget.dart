import 'package:flutter/material.dart';

class AvailabilityWidget extends StatelessWidget {
  final bool enable;
  final Widget child;
  final double disabledOpacity; // Optional opacity value for disabled state.

  const AvailabilityWidget({
    Key? key,
    required this.child,
    this.enable = true,
    this.disabledOpacity = 0.5, // Default opacity for disabled state.
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (enable) {
      return child;
    }
    return AbsorbPointer(
      absorbing: true,
      child: Opacity(
        // Reduce opacity for a more pronounced disabled effect.
        opacity: disabledOpacity,
        child: ColorFiltered(
          colorFilter: const ColorFilter.matrix([
            0.2126,
            0.7152,
            0.0722,
            0,
            0,
            0.2126,
            0.7152,
            0.0722,
            0,
            0,
            0.2126,
            0.7152,
            0.0722,
            0,
            0,
            0,
            0,
            0,
            1,
            0,
          ]),
          child: child,
        ),
      ),
    );
  }
}
