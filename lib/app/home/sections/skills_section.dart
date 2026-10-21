import 'package:flutter/material.dart';
import 'package:kainato_portfolio/core/data/portfolio_data.dart';
import 'package:kainato_portfolio/core/extension/context_extension.dart';
import 'package:kainato_portfolio/core/models/skill_category.dart';
import 'package:kainato_portfolio/widgets/base/section_tile.dart';
import 'package:kainato_portfolio/widgets/base/skill_chip.dart';

class SkillsSection extends StatelessWidget {
  final EdgeInsets sectionPadding;

  const SkillsSection({super.key, required this.sectionPadding});

  @override
  Widget build(BuildContext context) {
    final isMobile = context.isMobile;

    return Padding(
      padding: sectionPadding,
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1100),
          child: Column(
            children: [
              for (int i = 0; i < PortfolioData.skillsCategories.length; i++)
                Padding(
                  padding: EdgeInsets.only(
                    bottom: i < PortfolioData.skillsCategories.length - 1
                        ? 48
                        : 0,
                  ),
                  child: _SkillCategoryCard(
                    category: PortfolioData.skillsCategories[i],
                    isMobile: isMobile,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SkillCategoryCard extends StatefulWidget {
  final SkillCategory category;
  final bool isMobile;

  const _SkillCategoryCard({required this.category, required this.isMobile});

  @override
  State<_SkillCategoryCard> createState() => _SkillCategoryCardState();
}

class _SkillCategoryCardState extends State<_SkillCategoryCard> {
  bool _hovering = false;

  @override
  Widget build(BuildContext context) {
    final category = widget.category;
    final isMobile = widget.isMobile;

    return MouseRegion(
      onEnter: (_) => !isMobile ? setState(() => _hovering = true) : null,
      onExit: (_) => !isMobile ? setState(() => _hovering = false) : null,
      child: SectionTile(
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          decoration: BoxDecoration(
            border: Border.all(
              color: context.primaryColor.withValues(
                alpha: _hovering ? 0.4 : 0.1,
              ),
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Card(
            margin: EdgeInsets.zero,
            child: Padding(
              padding: const EdgeInsets.all(28),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Cabeçalho com ícone e título
                  Row(
                    children: [
                      Container(
                        width: 48,
                        height: 48,
                        decoration: BoxDecoration(
                          color: context.primaryColor.withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Icon(
                          category.icon,
                          color: context.primaryColor,
                          size: 24,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              category.name,
                              style: context.headlineSmall?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              category.description,
                              style: context.bodySmall?.copyWith(
                                color: context.onSurfaceVariantColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  // Wrap de skills
                  Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: [
                      for (final skill in category.skills)
                        SkillChip(skill: skill),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
