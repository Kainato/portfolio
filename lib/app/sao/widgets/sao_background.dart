import 'package:flutter/material.dart';

import '../sao_theme.dart';

/// Cenário estático do modo SAO para evitar repinturas contínuas no navegador.
class SaoBackground extends StatelessWidget {
  const SaoBackground({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return RepaintBoundary(
      child: Stack(
        children: [
          const Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    SaoColors.skyTop,
                    SaoColors.skyMid,
                    SaoColors.skyBottom,
                  ],
                  stops: [0, 0.45, 1],
                ),
              ),
            ),
          ),
          if (size.width > 760)
            Positioned(
              right: size.width * 0.06,
              top: size.height * 0.12,
              width: (size.width * 0.34).clamp(0.0, 420.0),
              child: const AspectRatio(
                aspectRatio: 4 / 3,
                child: CustomPaint(painter: _AincradPainter()),
              ),
            ),
          Positioned(
            left: -size.width * 0.25,
            right: -size.width * 0.25,
            bottom: -size.height * 0.1,
            height: size.height * 0.55,
            child: Transform(
              alignment: Alignment.bottomCenter,
              transform: Matrix4.identity()
                ..setEntry(3, 2, 0.002)
                ..rotateX(1.08),
              child: const CustomPaint(
                painter: _GridPainter(),
                size: Size.infinite,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _GridPainter extends CustomPainter {
  const _GridPainter();

  static const double _cell = 100;

  @override
  void paint(Canvas canvas, Size size) {
    final verticalPaint = Paint()
      ..color = SaoColors.blue.withValues(alpha: 0.12)
      ..strokeWidth = 1;
    for (double x = 0; x < size.width; x += _cell) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), verticalPaint);
    }

    for (double y = 0; y < size.height; y += _cell) {
      final fade = (1 - y / size.height).clamp(0.0, 1.0);
      final horizontalPaint = Paint()
        ..color = SaoColors.blue.withValues(alpha: 0.2 * fade)
        ..strokeWidth = 1;
      canvas.drawLine(Offset(0, y), Offset(size.width, y), horizontalPaint);
    }
  }

  @override
  bool shouldRepaint(_GridPainter old) => false;
}

class _AincradPainter extends CustomPainter {
  const _AincradPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5
      ..shader = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          SaoColors.blue.withValues(alpha: 0.3),
          SaoColors.blue.withValues(alpha: 0),
        ],
      ).createShader(rect);

    final cx = size.width / 2;
    // Andares do castelo: elipses cada vez maiores de cima para baixo
    const floors = [
      (0.13, 0.17, 0.04),
      (0.27, 0.25, 0.05),
      (0.42, 0.33, 0.07),
      (0.58, 0.39, 0.08),
      (0.77, 0.44, 0.09),
    ];
    for (final (y, rx, ry) in floors) {
      canvas.drawOval(
        Rect.fromCenter(
          center: Offset(cx, size.height * y),
          width: size.width * rx * 2,
          height: size.height * ry * 2,
        ),
        paint,
      );
    }
    canvas.drawLine(
      Offset(cx - size.width * 0.17, size.height * 0.13),
      Offset(cx - size.width * 0.44, size.height * 0.77),
      paint,
    );
    canvas.drawLine(
      Offset(cx + size.width * 0.17, size.height * 0.13),
      Offset(cx + size.width * 0.44, size.height * 0.77),
      paint,
    );
    canvas.drawLine(
      Offset(cx, size.height * 0.09),
      Offset(cx, size.height * 0.86),
      paint,
    );
  }

  @override
  bool shouldRepaint(_AincradPainter old) => false;
}
