import 'package:flutter/material.dart';
import 'package:kainato_portfolio/core/data/portfolio_data.dart';

import '../sao_data.dart';
import '../sao_theme.dart';
import '../widgets/sao_toast.dart';
import '../widgets/sao_widgets.dart';

/// Janela SKILLS: as categorias de [PortfolioData.skillsCategories] como
/// galhos de uma árvore, com nível de 1 a 5 em cada skill.
class SkillsPanel extends StatelessWidget {
  const SkillsPanel({super.key, required this.toasts});

  final SaoToastController toasts;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SaoGrid(
          minItemWidth: 240,
          spacing: 12,
          children: [
            for (final category in PortfolioData.skillsCategories)
              SaoCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(category.icon, size: 18, color: SaoColors.blue),
                        const SizedBox(width: 6),
                        Expanded(
                          child: Text(
                            category.name,
                            style: SaoText.display.copyWith(fontSize: 14),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 2),
                    Text(
                      category.description,
                      style: SaoText.body.copyWith(
                        fontSize: 12,
                        color: SaoColors.ink3,
                      ),
                    ),
                    const SizedBox(height: 8),
                    for (final skill in category.skills)
                      _SkillNode(
                        name: skill.name,
                        color: skill.color,
                        level: SaoData.skillLevels[skill.name] ?? 3,
                        onTap: () => toasts.show(
                          'Skill equipada',
                          '${skill.name} · nível ${SaoData.skillLevels[skill.name] ?? 3}',
                        ),
                      ),
                  ],
                ),
              ),
          ],
        ),
        const SaoNote(
          'Toque numa skill para equipá-la. Os níveis de 1 a 5 são de exemplo.',
        ),
      ],
    );
  }
}

class _SkillNode extends StatelessWidget {
  const _SkillNode({
    required this.name,
    required this.color,
    required this.level,
    required this.onTap,
  });

  final String name;
  final Color color;
  final int level;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: '$name, nível $level de 5',
      button: true,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        hoverColor: SaoColors.orangeSoft,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
          child: Row(
            children: [
              Container(
                width: 12,
                height: 12,
                decoration: BoxDecoration(
                  color: color,
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 2),
                  boxShadow: const [
                    BoxShadow(color: SaoColors.line, spreadRadius: 1),
                  ],
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  name,
                  style: SaoText.body.copyWith(
                    fontSize: 13.5,
                    color: SaoColors.ink,
                  ),
                ),
              ),
              for (var i = 1; i <= 5; i++)
                Container(
                  width: 6,
                  height: 10,
                  margin: const EdgeInsets.only(left: 2),
                  decoration: BoxDecoration(
                    color: i <= level
                        ? SaoColors.orange
                        : SaoColors.ink.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
