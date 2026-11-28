import 'package:flutter/material.dart';
import 'package:kainato_portfolio/core/data/portfolio_data.dart';
import 'package:kainato_portfolio/core/localization/app_language.dart';

import '../sao_data.dart';
import '../sao_theme.dart';
import 'sao_widgets.dart';

/// Janela de status fixa no canto superior esquerdo: avatar, nome, nível, HP e EXP.
class SaoHud extends StatelessWidget {
  const SaoHud({super.key, this.compact = false});

  final bool compact;

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
        padding: const EdgeInsets.fromLTRB(12, 10, 12, 10),
        child: SizedBox(
          width: compact ? 272 : 300,
          child: Row(
            children: [
              Container(
                width: compact ? 46 : 52,
                height: compact ? 46 : 52,
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
                    color: SaoColors.ink,
                    fontSize: compact ? 17 : 20,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              SizedBox(width: compact ? 10 : 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            PortfolioData.name,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: SaoText.display.copyWith(
                              fontSize: compact ? 14 : 16,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Tooltip(
                          triggerMode: TooltipTriggerMode.tap,
                          message: tr(
                            'Nível = anos de carreira desde Fev/2020.',
                          ),
                          child: Semantics(
                            label: tr(
                              'Nível = anos de carreira desde Fev/2020.',
                            ),
                            child: Text.rich(
                              TextSpan(
                                text: 'LV ',
                                style: SaoText.mono.copyWith(
                                  fontSize: compact ? 11 : 12,
                                  color: SaoColors.ink2,
                                ),
                                children: [
                                  TextSpan(
                                    text: '$level',
                                    style: TextStyle(
                                      color: SaoColors.orange,
                                      fontSize: compact ? 13 : 14,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: compact ? 5 : 6),
                    const SaoBar(
                      value: 1,
                      colors: [SaoColors.green, SaoColors.greenLight],
                    ),
                    _label(
                      'HP · Disponível para propostas',
                      '100/100',
                      tooltip: tr(
                        'Disponibilidade para novas propostas. 100/100 = disponível agora.',
                      ),
                    ),
                    SizedBox(height: compact ? 3 : 4),
                    SaoBar(
                      value: exp,
                      colors: const [SaoColors.orange, SaoColors.orangeLight],
                    ),
                    _label(
                      'EXP até o LV ${level + 1}',
                      '${(exp * 100).round()}%',
                      tooltip: tr(
                        'Progresso até completar mais um ano de experiência. Cada ano de carreira = 1 nível.',
                      ),
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

  Widget _label(String left, String right, {required String tooltip}) {
    final style = SaoText.mono.copyWith(fontSize: compact ? 9.8 : 10.5);
    return Tooltip(
      triggerMode: TooltipTriggerMode.tap,
      message: tooltip,
      child: Semantics(
        label: tooltip,
        child: Padding(
          padding: EdgeInsets.only(top: compact ? 2.5 : 3),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  left,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: style,
                ),
              ),
              const SizedBox(width: 8),
              Text(right, style: style),
            ],
          ),
        ),
      ),
    );
  }
}
