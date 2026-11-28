import 'package:flutter/material.dart';
import 'package:kainato_portfolio/core/data/portfolio_data.dart';

import '../sao_data.dart';
import '../sao_theme.dart';
import 'sao_widgets.dart';

/// Tela de abertura "LINK START" com anéis estáticos e checagem de sentidos.
///
/// Parâmetros:
/// - [onEnter]: entra no mundo (modo SAO).
/// - [onClassic]: volta para o portfólio clássico.
class SaoBootOverlay extends StatefulWidget {
  const SaoBootOverlay({
    super.key,
    required this.onEnter,
    required this.onClassic,
  });

  final VoidCallback onEnter;
  final VoidCallback onClassic;

  @override
  State<SaoBootOverlay> createState() => _SaoBootOverlayState();
}

class _SaoBootOverlayState extends State<SaoBootOverlay> {
  late final List<(String, String)> _lines = [
    ('Touch', 'OK'),
    ('Sight', 'OK'),
    ('Hearing', 'OK'),
    ('Language', 'PT-BR'),
    ('Carregando', 'LV ${SaoData.level}'),
    ('Bem-vindo,', PortfolioData.name),
  ];
  int _visibleLines = 0;
  bool _revealStarted = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final reduceMotion = MediaQuery.disableAnimationsOf(context);
    if (!_revealStarted) {
      _revealStarted = true;
      _revealLines(reduceMotion);
    }
  }

  Future<void> _revealLines(bool reduceMotion) async {
    if (reduceMotion) {
      setState(() => _visibleLines = _lines.length);
      return;
    }
    await Future.delayed(const Duration(milliseconds: 300));
    for (var i = 0; i < _lines.length; i++) {
      if (!mounted) return;
      setState(() => _visibleLines = i + 1);
      await Future.delayed(const Duration(milliseconds: 280));
    }
  }

  @override
  Widget build(BuildContext context) {
    final reduceMotion = MediaQuery.disableAnimationsOf(context);
    final titleSize = (MediaQuery.sizeOf(context).width * 0.07).clamp(
      34.0,
      84.0,
    );
    return DecoratedBox(
      decoration: const BoxDecoration(
        gradient: RadialGradient(
          radius: 1.1,
          colors: [
            SaoColors.surface,
            SaoColors.background,
            SaoColors.background,
          ],
          stops: [0, 0.45, 1],
        ),
      ),
      child: Stack(
        children: [
          const Positioned.fill(
            child: CustomPaint(painter: _BootRingsPainter()),
          ),
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text.rich(
                  TextSpan(
                    children: const [
                      TextSpan(text: 'LINK '),
                      TextSpan(
                        text: 'START',
                        style: TextStyle(color: SaoColors.orange),
                      ),
                    ],
                    style: SaoText.display.copyWith(
                      fontSize: titleSize,
                      fontWeight: FontWeight.w700,
                      letterSpacing: titleSize * 0.35,
                    ),
                  ),
                ),
                const SizedBox(height: 26),
                SizedBox(
                  width: 380,
                  height: 120,
                  child: Column(
                    children: [
                      for (var i = 0; i < _lines.length; i++)
                        AnimatedOpacity(
                          opacity: i < _visibleLines ? 1 : 0,
                          duration: reduceMotion
                              ? Duration.zero
                              : const Duration(milliseconds: 250),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                _lines[i].$1,
                                style: SaoText.mono.copyWith(
                                  fontSize: 13,
                                  color: SaoColors.ink2,
                                ),
                              ),
                              Text(
                                _lines[i].$2,
                                style: SaoText.mono.copyWith(
                                  fontSize: 13,
                                  color: SaoColors.green,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                    ],
                  ),
                ),
                const SizedBox(height: 22),
                Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  alignment: WrapAlignment.center,
                  children: [
                    SaoButton(
                      label: 'ENTRAR NO MUNDO',
                      onPressed: widget.onEnter,
                    ),
                    SaoButton(
                      label: 'PREFIRO O MODO CLÁSSICO',
                      onPressed: widget.onClassic,
                      primary: false,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _BootRingsPainter extends CustomPainter {
  const _BootRingsPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final center = size.center(Offset.zero);
    final maxRadius = size.shortestSide * 0.46;
    for (var i = 1; i <= 4; i++) {
      final paint = Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1
        ..color = SaoColors.blue.withValues(alpha: 0.13 / i);
      canvas.drawCircle(center, maxRadius * i / 4, paint);
    }
  }

  @override
  bool shouldRepaint(_BootRingsPainter old) => false;
}
