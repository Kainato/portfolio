import 'package:flutter/material.dart';
import 'package:kainato_portfolio/core/data/portfolio_data.dart';

import '../sao_data.dart';
import '../sao_theme.dart';
import 'sao_widgets.dart';

/// Janela de status fixa no canto superior esquerdo: avatar, nome, nível, HP e EXP.
class SaoHud extends StatelessWidget {
  const SaoHud({super.key});

  @override
  Widget build(BuildContext context) {
    final initials = PortfolioData.name
        .split(' ')
        .map((p) => p[0])
        .take(2)
        .join();
    final level = SaoData.level;
    final exp = SaoData.expProgress;

    return Semantics(
      label: 'Status do jogador: ${PortfolioData.name}, nível $level',
      child: SaoGlass(
        borderRadius: BorderRadius.circular(14),
        padding: const EdgeInsets.fromLTRB(12, 12, 16, 12),
        child: SizedBox(
          width: 300,
          child: Row(
            children: [
              Container(
                width: 52,
                height: 52,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  gradient: const LinearGradient(
                    colors: [SaoColors.blue, SaoColors.cyan],
                  ),
                  border: Border.all(
                    color: SaoColors.orange.withValues(alpha: 0.7),
                    width: 2,
                  ),
                ),
                child: Text(
                  initials,
                  style: SaoText.display.copyWith(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          PortfolioData.name,
                          style: SaoText.display.copyWith(fontSize: 16),
                        ),
                        Text.rich(
                          TextSpan(
                            text: 'LV ',
                            style: SaoText.mono.copyWith(
                              fontSize: 12,
                              color: SaoColors.ink2,
                            ),
                            children: [
                              TextSpan(
                                text: '$level',
                                style: const TextStyle(
                                  color: SaoColors.orange,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    const SaoBar(
                      value: 1,
                      colors: [SaoColors.green, SaoColors.greenLight],
                    ),
                    _label('HP · Disponível para propostas', '100/100'),
                    const SizedBox(height: 4),
                    SaoBar(
                      value: exp,
                      colors: const [SaoColors.orange, SaoColors.orangeLight],
                    ),
                    _label(
                      'EXP até o LV ${level + 1}',
                      '${(exp * 100).round()}%',
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _label(String left, String right) {
    final style = SaoText.mono.copyWith(fontSize: 10.5);
    return Padding(
      padding: const EdgeInsets.only(top: 3),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(left, style: style),
          Text(right, style: style),
        ],
      ),
    );
  }
}
