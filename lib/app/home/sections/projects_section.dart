import 'package:flutter/material.dart';
import 'package:kainato_portfolio/core/data/portfolio_data.dart';
import 'package:kainato_portfolio/core/extension/context_extension.dart';
import 'package:kainato_portfolio/core/models/portfolio_project.dart';
import 'package:kainato_portfolio/core/utils/kp_launcher.dart';
import 'package:kainato_portfolio/widgets/dialogs/kp_alert_dialog.dart';

/// Lista os projetos e cases cadastrados no portfólio.
///
/// Parâmetros:
/// - `sectionPadding`: espaçamento horizontal aplicado à seção.
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
          child: LayoutBuilder(
            builder: (context, constraints) {
              final columns = constraints.maxWidth >= 760 ? 2 : 1;
              final spacing = constraints.maxWidth >= 760 ? 24.0 : 16.0;
              final cardWidth =
                  (constraints.maxWidth - (spacing * (columns - 1))) / columns;
              return Wrap(
                spacing: spacing,
                runSpacing: spacing,
                children: [
                  for (final project in PortfolioData.projects)
                    SizedBox(
                      width: cardWidth,
                      child: _ProjectCard(project: project),
                    ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

/// Cartão com as informações e o link de um projeto.
///
/// Parâmetros:
/// - `project`: dados do projeto exibido no cartão.
class _ProjectCard extends StatefulWidget {
  final PortfolioProject project;
  const _ProjectCard({required this.project});

  @override
  State<_ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<_ProjectCard> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final project = widget.project;
    final colors = Theme.of(context).colorScheme;
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        curve: Curves.easeOut,
        transform: Matrix4.translationValues(0, _hovered ? -4 : 0, 0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          boxShadow: _hovered
              ? [
                  BoxShadow(
                    color: colors.shadow.withValues(alpha: 0.12),
                    blurRadius: 22,
                    offset: const Offset(0, 10),
                  ),
                ]
              : const [],
        ),
        child: Card(
          clipBehavior: Clip.antiAlias,
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: colors.primaryContainer,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        project.order,
                        style: TextStyle(
                          color: colors.onPrimaryContainer,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const Spacer(),
                    if (project.period != null)
                      Text(
                        project.period!,
                        style: context.bodySmall?.copyWith(
                          color: context.onSurfaceVariantColor,
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 18),
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
                const SizedBox(height: 16),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children:
                      (project.tags.isEmpty
                              ? project.stack.split(' • ')
                              : project.tags)
                          .map((tag) => _TechTag(label: tag))
                          .toList(),
                ),
                const SizedBox(height: 16),
                Text(
                  project.description,
                  style: context.bodyMedium?.copyWith(
                    height: 1.55,
                    color: context.onSurfaceVariantColor,
                  ),
                ),
                const SizedBox(height: 20),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    OutlinedButton.icon(
                      onPressed: () => _showDetails(context, project),
                      icon: const Icon(Icons.article_outlined, size: 18),
                      label: const Text('Ver detalhes'),
                    ),
                    if (project.repositoryUrl != null)
                      TextButton.icon(
                        onPressed: () =>
                            openExternalUrl(context, project.repositoryUrl!),
                        icon: const Icon(Icons.code, size: 18),
                        label: const Text('Repositório'),
                      ),
                    if (project.demoUrl != null)
                      TextButton.icon(
                        onPressed: () =>
                            openExternalUrl(context, project.demoUrl!),
                        icon: const Icon(Icons.open_in_new, size: 18),
                        label: const Text('Demo'),
                      ),
                    if (project.url != null)
                      TextButton.icon(
                        onPressed: () => openExternalUrl(context, project.url!),
                        icon: const Icon(Icons.launch, size: 18),
                        label: const Text('Ver case'),
                      ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _TechTag extends StatelessWidget {
  final String label;
  const _TechTag({required this.label});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: colors.secondaryContainer,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style: Theme.of(context).textTheme.labelMedium?.copyWith(
          color: colors.onSecondaryContainer,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

Future<void> _showDetails(BuildContext context, PortfolioProject project) {
  final screenSize = MediaQuery.sizeOf(context);
  return showKpAlertDialog(
    context: context,
    title: project.title,
    contentWidget: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (project.period != null) ...[
            Text(
              project.period!,
              style: Theme.of(context).textTheme.labelLarge,
            ),
            const SizedBox(height: 18),
          ],
          _DetailBlock(
            title: 'Contexto e desafio',
            body: project.challenge ?? project.subtitle,
          ),
          _DetailBlock(
            title: 'Solução',
            body: project.solution ?? project.description,
          ),
          if (project.impact != null)
            _DetailBlock(title: 'Impacto', body: project.impact!),
          _DetailBlock(
            title: 'Tecnologias',
            body: project.tags.isEmpty
                ? project.stack
                : project.tags.join(' • '),
          ),
        ],
      ),
    ),
    confirmLabel: 'Fechar',
    showCancelButton: false,
    size: Size(
      screenSize.width < 640 ? screenSize.width * 0.9 : 640,
      screenSize.height * 0.78,
    ),
  );
}

class _DetailBlock extends StatelessWidget {
  final String title;
  final String body;
  const _DetailBlock({required this.title, required this.body});

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.only(bottom: 16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 5),
        Text(body, style: Theme.of(context).textTheme.bodyMedium),
      ],
    ),
  );
}
