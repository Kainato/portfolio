import 'package:flutter/material.dart';
import 'package:kainato_portfolio/core/data/portfolio_data.dart';
import 'package:kainato_portfolio/core/extension/context_extension.dart';
import 'package:kainato_portfolio/core/models/portfolio_project.dart';
import 'package:kainato_portfolio/core/utils/kp_launcher.dart';
import 'package:kainato_portfolio/widgets/base/section_tile.dart';

class ProjectsSection extends StatelessWidget {
  final EdgeInsets sectionPadding;

  const ProjectsSection({super.key, required this.sectionPadding});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: sectionPadding,
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1100),
          child: Column(
            children: [
              for (final project in PortfolioData.projects)
                _ProjectCard(project: project),
            ],
          ),
        ),
      ),
    );
  }
}

class _ProjectCard extends StatelessWidget {
  final PortfolioProject project;
  const _ProjectCard({required this.project});

  @override
  Widget build(BuildContext context) {
    final url = project.url;
    return SectionTile(
      semanticLabel: url != null ? 'Abrir projeto ${project.title}' : null,
      onTap: url != null ? () => openExternalUrl(context, url) : null,
      child: Card(
        margin: const EdgeInsets.only(bottom: 24),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                project.order,
                style: TextStyle(
                  color: context.primaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                project.title,
                style: context.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                project.subtitle,
                style: context.bodyLarge?.copyWith(
                  color: context.onSurfaceVariantColor,
                ),
              ),
              const SizedBox(height: 18),
              Text(
                project.stack,
                style: TextStyle(color: context.tertiaryColor),
              ),
              const SizedBox(height: 18),
              Text(
                project.description,
                style: context.bodyMedium?.copyWith(
                  height: 1.5,
                  color: context.onSurfaceVariantColor,
                ),
              ),
              if (url != null) ...[
                const SizedBox(height: 18),
                Semantics(
                  button: true,
                  label: 'Ver case de ${project.title}',
                  child: TextButton(
                    onPressed: () => openExternalUrl(context, url),
                    child: const Text('Ver case →'),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
