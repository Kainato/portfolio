import 'package:flutter/material.dart';
import 'package:kainato_portfolio/core/data/portfolio_data.dart';

import '../sao_data.dart';
import '../sao_theme.dart';
import '../widgets/sao_widgets.dart';

/// Janela STATUS: classe, resumo, números do portfólio e atributos.
class StatusPanel extends StatelessWidget {
  const StatusPanel({super.key});

  @override
  Widget build(BuildContext context) {
    final totalSkills = PortfolioData.skillsCategories.fold<int>(
      0,
      (sum, c) => sum + c.skills.length,
    );
    final stats = [
      ('Nível', '${SaoData.level}', true),
      ('Missões', '${PortfolioData.projects.length}', false),
      ('Skills', '$totalSkills', false),
      ('Guildas', '${PortfolioData.experiences.length}', false),
      ('Clínicas atendidas', '10+', false),
      ('Lojas publicadas', '2', false),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(
            color: SaoColors.orangeSoft,
            borderRadius: BorderRadius.circular(999),
          ),
          child: Text(
            '◆ CLASSE: ${PortfolioData.role.toUpperCase()}',
            style: SaoText.mono.copyWith(
              fontSize: 12,
              color: SaoColors.orangeText,
            ),
          ),
        ),
        const SizedBox(height: 10),
        Text(
          PortfolioData.heroDescription,
          style: SaoText.body.copyWith(fontSize: 15),
        ),
        const SizedBox(height: 14),
        SaoGrid(
          columns: 3,
          minItemWidth: 140,
          children: [
            for (final (label, value, highlight) in stats)
              SaoCard(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      label.toUpperCase(),
                      style: SaoText.mono.copyWith(fontSize: 10.5),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      value,
                      style: SaoText.display.copyWith(
                        fontSize: 24,
                        color: highlight ? SaoColors.orange : SaoColors.ink,
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
        const SaoSectionLabel('Atributos'),
        for (final (name, value) in SaoData.attributes)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: Row(
              children: [
                SizedBox(
                  width: 130,
                  child: Text(
                    name,
                    style: SaoText.body.copyWith(
                      fontSize: 13,
                      color: SaoColors.ink,
                    ),
                  ),
                ),
                Expanded(
                  child: SaoBar(
                    value: value / 100,
                    colors: const [SaoColors.blue, SaoColors.cyan],
                  ),
                ),
                SizedBox(
                  width: 36,
                  child: Text(
                    '$value',
                    textAlign: TextAlign.right,
                    style: SaoText.mono.copyWith(color: SaoColors.ink2),
                  ),
                ),
              ],
            ),
          ),
        const SaoNote(
          'Atributos e níveis de skill são valores de exemplo, definidos em sao_data.dart.',
        ),
      ],
    );
  }
}
