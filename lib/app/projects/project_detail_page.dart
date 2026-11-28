import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_markdown_plus/flutter_markdown_plus.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../core/data/portfolio_data.dart';
import '../../core/localization/app_language.dart';
import '../../core/models/portfolio_project.dart';
import '../../core/theme/app_colors.dart';
import '../../widgets/layout/mode_sound_controls.dart';

class ProjectDetailPage extends StatefulWidget {
  const ProjectDetailPage({super.key, required this.slug});
  final String slug;

  @override
  State<ProjectDetailPage> createState() => _ProjectDetailPageState();
}

class _ProjectDetailPageState extends State<ProjectDetailPage> {
  late final Future<String> _markdown = rootBundle.loadString(
    'assets/projects/${widget.slug}.md',
  );

  PortfolioProject? get _project {
    for (final item in PortfolioData.projects) {
      if (item.slug == widget.slug) return item;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final project = _project;
    if (project == null) return _errorPage(context);
    final theme = Theme.of(context);
    final compact = MediaQuery.sizeOf(context).width < 600;
    return Scaffold(
      body: Stack(
        children: [
          SelectionArea(
            child: ListView(
              padding: EdgeInsets.fromLTRB(
                compact ? 18 : 32,
                24,
                compact ? 18 : 32,
                130,
              ),
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Semantics(
                    button: true,
                    label: tr('Voltar à página anterior'),
                    child: TextButton.icon(
                      onPressed: () => context.pop(),
                      icon: const Icon(Icons.arrow_back),
                      label: Text(tr('Voltar')),
                    ),
                  ),
                ),
                const SizedBox(height: 26),
                Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 920),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Hero(
                          tag: 'project-title-${project.slug}',
                          child: Material(
                            color: Colors.transparent,
                            child: Text(
                              project.title,
                              style: theme.textTheme.headlineLarge?.copyWith(
                                color: AppColors.textPrimary,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ),
                        ),
                        if (project.period != null) ...[
                          const SizedBox(height: 10),
                          Text(
                            project.period!,
                            style: theme.textTheme.bodyMedium,
                          ),
                        ],
                        if (project.tags.isNotEmpty) ...[
                          const SizedBox(height: 16),
                          Wrap(
                            spacing: 8,
                            runSpacing: 8,
                            children: project.tags
                                .map((tag) => Chip(label: Text(tag)))
                                .toList(),
                          ),
                        ],
                        const SizedBox(height: 24),
                        Container(
                          width: double.infinity,
                          height: 180,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: AppColors.surface,
                            border: Border.all(color: AppColors.surfaceRaised),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Text(
                            tr('Imagens do projeto serão adicionadas aqui.'),
                            style: const TextStyle(
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ),
                        const SizedBox(height: 28),
                        FutureBuilder<String>(
                          future: _markdown,
                          builder: (context, snapshot) {
                            if (snapshot.hasError) {
                              return _inlineError(context);
                            }
                            if (!snapshot.hasData) {
                              return const Padding(
                                padding: EdgeInsets.all(20),
                                child: Center(
                                  child: CircularProgressIndicator(),
                                ),
                              );
                            }
                            return MarkdownBody(
                              data: snapshot.data!,
                              styleSheet: MarkdownStyleSheet.fromTheme(theme)
                                  .copyWith(
                                    h1: theme.textTheme.headlineMedium
                                        ?.copyWith(
                                          color: AppColors.textPrimary,
                                        ),
                                    h2: theme.textTheme.titleLarge?.copyWith(
                                      color: AppColors.accent,
                                    ),
                                    p: theme.textTheme.bodyLarge?.copyWith(
                                      height: 1.7,
                                      color: AppColors.textSecondary,
                                    ),
                                    a: const TextStyle(
                                      color: AppColors.accent,
                                      decoration: TextDecoration.underline,
                                    ),
                                    blockquoteDecoration: const BoxDecoration(
                                      border: Border(
                                        left: BorderSide(
                                          color: AppColors.accent,
                                          width: 3,
                                        ),
                                      ),
                                    ),
                                  ),
                              onTapLink: (_, href, _) {
                                if (href == null) return;
                                launchUrl(
                                  Uri.parse(href),
                                  mode: LaunchMode.externalApplication,
                                );
                              },
                            );
                          },
                        ),
                        if (project.url != null ||
                            project.repositoryUrl != null ||
                            project.demoUrl != null) ...[
                          const SizedBox(height: 20),
                          Wrap(
                            spacing: 12,
                            runSpacing: 12,
                            children: [
                              for (final link in [
                                project.url,
                                project.repositoryUrl,
                                project.demoUrl,
                              ])
                                if (link != null && link.isNotEmpty)
                                  OutlinedButton.icon(
                                    onPressed: () => launchUrl(
                                      Uri.parse(link),
                                      mode: LaunchMode.externalApplication,
                                    ),
                                    icon: const Icon(Icons.open_in_new),
                                    label: Text(tr('Abrir link externo')),
                                  ),
                            ],
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Positioned(right: 16, bottom: 16, child: ModeSoundControls()),
        ],
      ),
    );
  }

  Widget _inlineError(BuildContext context) => Padding(
    padding: const EdgeInsets.all(18),
    child: Text(
      tr('Não foi possível carregar os detalhes deste projeto.'),
      style: Theme.of(
        context,
      ).textTheme.bodyLarge?.copyWith(color: AppColors.error),
    ),
  );

  Widget _errorPage(BuildContext context) => Scaffold(
    body: Stack(
      children: [
        Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.description_outlined,
                  color: AppColors.textSecondary,
                  size: 36,
                ),
                const SizedBox(height: 12),
                Text(
                  tr('Não foi possível carregar os detalhes deste projeto.'),
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 12),
                FilledButton(
                  onPressed: () => context.go('/'),
                  child: Text(tr('Voltar ao portfólio')),
                ),
              ],
            ),
          ),
        ),
        const Positioned(right: 16, bottom: 16, child: ModeSoundControls()),
      ],
    ),
  );
}
