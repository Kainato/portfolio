import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../core/audio/sound_service.dart';
import '../../core/data/portfolio_data.dart';
import '../../core/localization/app_language.dart';
import '../../core/models/portfolio_project.dart';
import '../../core/models/skill.dart';
import '../../core/theme/app_colors.dart';
import '../../widgets/base/scroll_reveal.dart';
import '../../widgets/layout/mode_sound_controls.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
    body: Stack(
      children: [
        CustomScrollView(
          slivers: [
            SliverToBoxAdapter(child: ScrollReveal(child: _HeroSection())),
            SliverToBoxAdapter(child: ScrollReveal(child: _LinkStartCallout())),
            SliverToBoxAdapter(child: ScrollReveal(child: _SkillsSection())),
            SliverToBoxAdapter(child: ScrollReveal(child: _ProjectsSection())),
            SliverToBoxAdapter(child: ScrollReveal(child: _ContactSection())),
            const SliverToBoxAdapter(child: SizedBox(height: 112)),
          ],
        ),
        const Positioned(
          right: 16,
          bottom: 16,
          child: ModeSoundControls(isSao: false),
        ),
        const Positioned(right: 18, top: 18, child: _LanguageSelector()),
      ],
    ),
  );
}

class _HeroSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final compact = MediaQuery.sizeOf(context).width < 640;
    return _PageWidth(
      child: Padding(
        padding: EdgeInsets.fromLTRB(24, compact ? 72 : 110, 24, 64),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              tr(PortfolioData.role).toUpperCase(),
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                color: AppColors.accent,
                letterSpacing: 2.2,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              PortfolioData.name,
              style: Theme.of(context).textTheme.displayMedium?.copyWith(
                fontWeight: FontWeight.w800,
                height: 1.05,
              ),
            ),
            const SizedBox(height: 18),
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 700),
              child: Text(
                tr(PortfolioData.heroDescription),
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: AppColors.textSecondary,
                  height: 1.65,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _LinkStartCallout extends StatelessWidget {
  @override
  Widget build(BuildContext context) => _PageWidth(
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: AppColors.surface,
          border: Border.all(color: AppColors.surfaceRaised),
          borderRadius: BorderRadius.circular(18),
        ),
        child: LayoutBuilder(
          builder: (context, constraints) {
            final compact = constraints.maxWidth < 560;
            final children = [
              const Icon(
                Icons.bolt_rounded,
                color: AppColors.highlight,
                size: 28,
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  tr(
                    'Explore o portfólio em uma interface interativa inspirada em RPG.',
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Semantics(
                button: true,
                label: 'Abrir o modo SAO do portfólio',
                child: FilledButton.icon(
                  onPressed: () {
                    SoundService.instance.play(SoundEffect.linkStart);
                    context.push('/sao');
                  },
                  icon: const Icon(Icons.arrow_forward),
                  label: const Text('LINK START'),
                ),
              ),
            ];
            if (!compact) return Row(children: children);
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.bolt_rounded,
                      color: AppColors.highlight,
                      size: 28,
                    ),
                    SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        tr(
                          'Explore o portfólio em uma interface interativa inspirada em RPG.',
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 14),
                Align(
                  alignment: Alignment.centerRight,
                  child: FilledButton.icon(
                    onPressed: () {
                      SoundService.instance.play(SoundEffect.linkStart);
                      context.push('/sao');
                    },
                    icon: const Icon(Icons.arrow_forward),
                    label: const Text('LINK START'),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    ),
  );
}

class _SkillsSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) => _Section(
    title: tr('Skills'),
    child: Wrap(
      spacing: 10,
      runSpacing: 10,
      children: [
        for (final skill in PortfolioData.skills) _SkillChip(skill: skill),
      ],
    ),
  );
}

class _SkillChip extends StatefulWidget {
  const _SkillChip({required this.skill});
  final Skill skill;

  @override
  State<_SkillChip> createState() => _SkillChipState();
}

class _SkillChipState extends State<_SkillChip> {
  bool _hover = false;
  @override
  Widget build(BuildContext context) => MouseRegion(
    cursor: SystemMouseCursors.click,
    onEnter: (_) => setState(() => _hover = true),
    onExit: (_) => setState(() => _hover = false),
    child: Semantics(
      button: true,
      label: 'Abrir referência de ${widget.skill.name}',
      child: ActionChip(
        onPressed: () {
          SoundService.instance.play(SoundEffect.classicClick);
          launchUrl(
            Uri.parse(widget.skill.url),
            mode: LaunchMode.externalApplication,
          );
        },
        avatar: Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(
            color: widget.skill.color,
            shape: BoxShape.circle,
          ),
        ),
        label: Text(widget.skill.name),
        backgroundColor: AppColors.surface,
        side: BorderSide(
          color: _hover ? AppColors.highlight : AppColors.surfaceRaised,
        ),
        labelStyle: const TextStyle(color: AppColors.textPrimary),
      ),
    ),
  );
}

class _ProjectsSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) => _Section(
    title: tr('Projetos'),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _ProjectGroup(
          title: tr('Experiência de trabalho'),
          description: tr(
            'Produtos e entregas desenvolvidos em contextos profissionais.',
          ),
          category: ProjectCategory.work,
        ),
        const SizedBox(height: 38),
        _ProjectGroup(
          title: tr('Laboratório de programação'),
          description: tr(
            'Projetos próprios para estudo, experimentação e compartilhamento.',
          ),
          category: ProjectCategory.lab,
        ),
      ],
    ),
  );
}

class _ProjectGroup extends StatelessWidget {
  const _ProjectGroup({
    required this.title,
    required this.description,
    required this.category,
  });
  final String title;
  final String description;
  final ProjectCategory category;

  @override
  Widget build(BuildContext context) {
    final projects = PortfolioData.projects
        .where((item) => item.category == category)
        .toList();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(
            context,
          ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 6),
        Text(
          description,
          style: const TextStyle(color: AppColors.textSecondary),
        ),
        const SizedBox(height: 18),
        LayoutBuilder(
          builder: (context, constraints) {
            final count = constraints.maxWidth > 900
                ? 3
                : constraints.maxWidth > 580
                ? 2
                : 1;
            const gap = 14.0;
            final width = (constraints.maxWidth - gap * (count - 1)) / count;
            return Wrap(
              spacing: gap,
              runSpacing: gap,
              children: [
                for (final project in projects)
                  SizedBox(
                    width: width,
                    child: _ProjectCard(project: project),
                  ),
              ],
            );
          },
        ),
      ],
    );
  }
}

class _ProjectCard extends StatefulWidget {
  const _ProjectCard({required this.project});
  final PortfolioProject project;
  @override
  State<_ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<_ProjectCard> {
  bool _hover = false;
  @override
  Widget build(BuildContext context) => MouseRegion(
    cursor: SystemMouseCursors.click,
    onEnter: (_) => setState(() => _hover = true),
    onExit: (_) => setState(() => _hover = false),
    child: Focus(
      onFocusChange: (focus) => setState(() => _hover = focus),
      child: Semantics(
        button: true,
        label: 'Ver detalhes de ${widget.project.title}',
        child: InkWell(
          onTap: () {
            SoundService.instance.play(SoundEffect.classicClick);
            context.push('/projetos/${widget.project.slug}');
          },
          borderRadius: BorderRadius.circular(16),
          child: AnimatedContainer(
            duration: MediaQuery.disableAnimationsOf(context)
                ? Duration.zero
                : const Duration(milliseconds: 150),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: _hover ? AppColors.highlight : AppColors.surfaceRaised,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Hero(
                  tag: 'project-title-${widget.project.slug}',
                  child: Material(
                    color: Colors.transparent,
                    child: Text(
                      widget.project.title,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: AppColors.textPrimary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  widget.project.subtitle,
                  style: const TextStyle(
                    color: AppColors.textSecondary,
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 14),
                Text(
                  widget.project.stack,
                  style: const TextStyle(color: AppColors.accent, fontSize: 12),
                ),
                const SizedBox(height: 12),
                const Align(
                  alignment: Alignment.centerRight,
                  child: Icon(
                    Icons.arrow_outward,
                    size: 17,
                    color: AppColors.accent,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}

class _ContactSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) => _Section(
    title: tr('Contato'),
    child: Wrap(
      spacing: 12,
      runSpacing: 12,
      children: [
        for (final item in PortfolioData.contacts)
          OutlinedButton.icon(
            onPressed: () async {
              SoundService.instance.play(SoundEffect.classicClick);
              if (item.type.name == 'email') {
                await Clipboard.setData(ClipboardData(text: item.value));
                if (context.mounted) {
                  SoundService.instance.play(SoundEffect.emailCopied);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        tr('E-mail copiado para a área de transferência.'),
                      ),
                    ),
                  );
                }
              } else {
                launchUrl(
                  Uri.parse(item.url),
                  mode: LaunchMode.externalApplication,
                );
              }
            },
            icon: Icon(item.icon),
            label: Text(
              item.type.name == 'email' ? tr('Copiar e-mail') : tr(item.label),
            ),
          ),
      ],
    ),
  );
}

class _Section extends StatelessWidget {
  const _Section({required this.title, required this.child});
  final String title;
  final Widget child;
  @override
  Widget build(BuildContext context) => _PageWidth(
    child: Padding(
      padding: const EdgeInsets.fromLTRB(24, 48, 24, 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            tr(title),
            style: Theme.of(
              context,
            ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 22),
          child,
        ],
      ),
    ),
  );
}

class _PageWidth extends StatelessWidget {
  const _PageWidth({required this.child});
  final Widget child;
  @override
  Widget build(BuildContext context) => Center(
    child: ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 1100),
      child: child,
    ),
  );
}

class _LanguageSelector extends StatelessWidget {
  const _LanguageSelector();

  @override
  Widget build(BuildContext context) => AnimatedBuilder(
    animation: AppLanguageController.instance,
    builder: (context, _) {
      final controller = AppLanguageController.instance;
      return Semantics(
        label: tr('Selecionar idioma'),
        child: PopupMenuButton<AppLanguage>(
          tooltip: tr('Selecionar idioma'),
          initialValue: controller.language,
          onSelected: controller.setLanguage,
          itemBuilder: (context) => const [
            PopupMenuItem(
              value: AppLanguage.ptBr,
              child: Text('Português (Brasil)'),
            ),
            PopupMenuItem(value: AppLanguage.enUs, child: Text('English (US)')),
          ],
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 9),
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(24),
              border: Border.all(color: AppColors.surfaceRaised),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.language, size: 17, color: AppColors.accent),
                const SizedBox(width: 6),
                Text(
                  controller.isEnglish ? 'EN' : 'PT',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 11,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}
