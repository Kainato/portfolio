import 'package:flutter/material.dart';

import '../sao_theme.dart';

/// Fundo estático e barato para pintura no Flutter Web.
class SaoBackground extends StatelessWidget {
  const SaoBackground({super.key});

  @override
  Widget build(BuildContext context) => const RepaintBoundary(
    child: DecoratedBox(
      decoration: BoxDecoration(
        color: SaoColors.skyTop,
        gradient: RadialGradient(
          center: Alignment(0.85, -0.8),
          radius: 1.3,
          colors: [SaoColors.surfaceRaised, SaoColors.skyTop],
        ),
      ),
    ),
  );
}
