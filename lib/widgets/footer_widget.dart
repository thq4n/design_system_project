import 'dart:math';

import 'package:flutter/material.dart';

import '../design_system_project.dart';

class FooterWidget extends StatelessWidget {
  const FooterWidget({
    Key? key,
    required this.child,
    this.alignment,
    this.backgroundColor,
    this.padding = const EdgeInsets.all(16),
    this.decoration,
  }) : super(key: key);

  final Widget child;
  final AlignmentGeometry? alignment;
  final Color? backgroundColor;
  final EdgeInsets padding;
  final Decoration? decoration;

  @override
  Widget build(BuildContext context) {
    final paddingBottom = MediaQuery.of(context).padding.bottom;
    return Container(
      width: double.infinity,
      decoration: decoration ??
          BoxDecoration(
            color: backgroundColor ?? DSColorUsages.background.primary,
            boxShadow: DSShadows.light.boxShadows,
          ),
      padding: EdgeInsets.only(
        bottom: max(paddingBottom, padding.bottom),
        right: padding.right,
        left: padding.left,
        top: padding.top,
      ),
      alignment: alignment,
      child: child,
    );
  }
}
