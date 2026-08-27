part of '../../ds_gradients_core.dart';

class _DSGreenGradient1 extends DSGradient {
  const _DSGreenGradient1();

  @override
  List<Color> get colors => const [
        Color(0xFF039855),
        Color(0xFF12B76A),
      ];

  @override
  List<double> get stops => const [0.0, 1.0];
}

class _DSGreenGradient2 extends DSGradient {
  const _DSGreenGradient2();

  @override
  List<Color> get colors => const [
        Color(0xFF039836),
        Color(0xFF12B75E),
      ];

  @override
  List<double> get stops => const [0.0, 1.0];
}
