import 'package:flutter/material.dart';
import 'package:kainato_portfolio/core/data/portfolio_data.dart';

import '../sao_data.dart';
import '../sao_theme.dart';
import '../widgets/sao_widgets.dart';

/// Janela ANDARES: a trajetória profissional como andares de Aincrad,
/// do mais antigo ao mais recente, terminando no próximo andar a explorar.
class FloorsPanel extends StatelessWidget {
  const FloorsPanel({super.key});

  @override
  Widget build(BuildContext context) {
    // PortfolioData.experiences está do mais recente para o mais antigo
    final experiences = PortfolioData.experiences.reversed.toList();
    final nextFloor = (SaoData.level + 1).toString().padLeft(2, '0');

    return Stack(
      children: [
        Positioned(
          left: 9,
          top: 6,
          bottom: 6,
          child: Container(
            width: 2,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [SaoColors.orange, SaoColors.blue],
              ),
            ),
          ),
        ),
        Column(
          children: [
            for (var i = 0; i < experiences.length; i++)
              _Floor(
                tag:
                    'GUILDA ${(i + 1).toString().padLeft(2, '0')} · ANDAR CONCLUÍDO',
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      experiences[i].company,
                      style: SaoText.display.copyWith(fontSize: 16),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      '${experiences[i].role} · ${experiences[i].period}',
                      style: SaoText.body.copyWith(
                        fontSize: 12.5,
                        color: SaoColors.ink3,
                      ),
                    ),
                    const SizedBox(height: 8),
                    for (final highlight in experiences[i].highlights)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 6),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(top: 5, right: 6),
                              child: Icon(
                                Icons.diamond,
                                size: 8,
                                color: SaoColors.blue,
                              ),
                            ),
                            Expanded(
                              child: Text.rich(
                                TextSpan(
                                  children: [
                                    TextSpan(
                                      text: '${highlight.title}: ',
                                      style: const TextStyle(
                                        color: SaoColors.ink,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    TextSpan(text: highlight.description),
                                  ],
                                ),
                                style: SaoText.body.copyWith(fontSize: 13),
                              ),
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
              ),
            _Floor(
              tag: 'ANDAR $nextFloor · NÃO EXPLORADO',
              pending: true,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Próxima guilda',
                    style: SaoText.display.copyWith(fontSize: 16),
                  ),
                  Text(
                    'Aberto a oportunidades em Flutter mobile e web.',
                    style: SaoText.body.copyWith(
                      fontSize: 12.5,
                      color: SaoColors.ink3,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _Floor extends StatelessWidget {
  const _Floor({required this.tag, required this.child, this.pending = false});

  final String tag;
  final Widget child;
  final bool pending;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 20,
            height: 20,
            margin: const EdgeInsets.only(top: 14, right: 8),
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              border: Border.all(
                color: pending ? SaoColors.ink3 : SaoColors.orange,
                width: 3,
              ),
            ),
          ),
          Expanded(
            child: SaoCard(
              dashed: pending,
              padding: const EdgeInsets.fromLTRB(16, 14, 16, 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    tag,
                    style: SaoText.mono.copyWith(
                      color: pending ? SaoColors.ink3 : SaoColors.orange,
                      letterSpacing: 1.4,
                    ),
                  ),
                  const SizedBox(height: 2),
                  child,
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
