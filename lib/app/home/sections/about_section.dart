import 'package:flutter/material.dart';
import 'package:kainato_portfolio/core/data/portfolio_data.dart';
import 'package:kainato_portfolio/core/extension/context_extension.dart';
import 'package:kainato_portfolio/widgets/base/section_tile.dart';
import 'package:kainato_portfolio/widgets/base/skill_chip.dart';

class AboutSection extends StatelessWidget {
  final EdgeInsets sectionPadding;

  const AboutSection({super.key, required this.sectionPadding});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: sectionPadding,
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1100),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Wrap(
                spacing: 24,
                runSpacing: 24,
                children: [
                  _InfoCard(
                    title: '6+ anos',
                    text: 'Experiência com desenvolvimento Flutter & Dart',
                  ),
                  _InfoCard(
                    title: 'Full Stack Mobile',
                    text: 'Provider, MobX, GetX, Laravel e Filament',
                  ),
                  _InfoCard(
                    title: 'Produto',
                    text: 'Foco em problema, usuário e resultado de negócio',
                  ),
                ],
              ),
              const SizedBox(height: 40),
              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: [
                  for (final skill in PortfolioData.skills)
                    SkillChip(skill: skill),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _InfoCard extends StatelessWidget {
  final String title;
  final String text;
  const _InfoCard({required this.title, required this.text});

  @override
  Widget build(BuildContext context) {
    return SectionTile(
      child: SizedBox(
        width: context.isMobile ? context.width - 40 : 340,
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(26),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: context.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  text,
                  style: context.bodyMedium?.copyWith(
                    color: context.onSurfaceVariantColor,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
