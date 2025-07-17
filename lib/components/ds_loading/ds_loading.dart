import 'package:flutter/cupertino.dart';

class Loading extends StatelessWidget {
  final Brightness? brightness;
  final double radius;
  final Color? color;

  const Loading({super.key, this.brightness, this.radius = 15, this.color});

  @override
  Widget build(BuildContext context) {
    return CupertinoTheme(
      data: CupertinoTheme.of(context).copyWith(brightness: brightness),
      child: CupertinoActivityIndicator(radius: radius, color: color),
    );
  }
}
