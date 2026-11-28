import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/audio/sound_service.dart';
import '../../../core/data/portfolio_data.dart';
import '../../../core/models/portfolio_project.dart';
import '../sao_data.dart';
import '../sao_theme.dart';
import '../widgets/sao_widgets.dart';

class QuestsPanel extends StatelessWidget {
  const QuestsPanel({super.key});

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _group(
        context,
        'Missões de guilda',
        'Experiência profissional.',
        ProjectCategory.work,
      ),
      const SizedBox(height: 12),
      _group(
        context,
        'Missões solo',
        'Projetos próprios e laboratório.',
        ProjectCategory.lab,
      ),
    ],
  );

  Widget _group(
    BuildContext context,
    String title,
    String description,
    ProjectCategory category,
  ) {
    final projects = PortfolioData.projects.where(
      (p) => p.category == category,
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SaoSectionLabel(title),
        Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Text(description, style: SaoText.body),
        ),
        for (final project in projects)
          Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: SaoCard(
              onTap: () {
                SoundService.instance.play(SoundEffect.select);
                context.push('/projetos/${project.slug}');
              },
              padding: const EdgeInsets.all(12),
              child: Row(
                children: [
                  SizedBox(
                    width: 38,
                    child: Text(
                      project.order,
                      textAlign: TextAlign.center,
                      style: SaoText.display.copyWith(
                        fontSize: 20,
                        color: SaoColors.orange,
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          project.title,
                          style: SaoText.display.copyWith(
                            fontSize: 14,
                            letterSpacing: 0.2,
                          ),
                        ),
                        const SizedBox(height: 3),
                        Text(
                          project.stack,
                          style: SaoText.body.copyWith(fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                  _RankBadge(rank: SaoData.questRanks[project.order] ?? 'A'),
                  const SizedBox(width: 4),
                  const Icon(
                    Icons.open_in_new,
                    size: 16,
                    color: SaoColors.blue,
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }
}

class _RankBadge extends StatelessWidget {
  const _RankBadge({required this.rank});
  final String rank;

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
    decoration: BoxDecoration(
      color: SaoColors.orangeSoft,
      borderRadius: BorderRadius.circular(6),
    ),
    child: Text(
      'RANK $rank',
      style: SaoText.mono.copyWith(color: SaoColors.orangeText),
    ),
  );
}
