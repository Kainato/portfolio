import 'package:flutter/material.dart';
import 'package:kainato_portfolio/app/home/home_controller.dart';

import '../../core/data/portfolio_data.dart';
import '../../core/extension/context_extension.dart';
import '../../core/routes/kp_routes.dart';
import '../../widgets/base/kp_intro.dart';
import '../../widgets/base/scroll_reveal.dart';
import '../../widgets/layout/kp_scaffold.dart';
import 'sections/about_section.dart';
import 'sections/contact_section.dart';
import 'sections/hero_section.dart';
import 'sections/process_section.dart';
import 'sections/projects_section.dart';
import 'sections/skills_section.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final HomeController _controller = HomeController();

  @override
  Widget build(BuildContext context) => KpScaffold(
    route: KpRoutes.home,
    onSectionTap: _controller.scrollToSection,
    body: SelectionArea(
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: ScrollReveal(
              child: HeroSection(
                onProjectsTap: () => _controller.scrollToSection('projetos'),
              ),
            ),
          ),
          SliverToBoxAdapter(
            key: _controller.sobreKey,
            child: const SizedBox.shrink(),
          ),
          KpIntro(
            title: 'SOBRE MIM',
            content: PortfolioData.about,
          ).buildSliver(context),
          SliverToBoxAdapter(
            child: ScrollReveal(
              child: AboutSection(
                sectionPadding: _controller.sectionPadding(context),
              ),
            ),
          ),
          SliverToBoxAdapter(
            key: _controller.habilidadesKey,
            child: const SizedBox.shrink(),
          ),
          KpIntro(
            title: 'HABILIDADES',
            content:
                'Tecnologias, linguagens, frameworks e ferramentas que domino e utilizo no dia a dia.',
          ).buildSliver(context),
          SliverToBoxAdapter(
            child: ScrollReveal(
              child: SkillsSection(
                sectionPadding: _controller.sectionPadding(context),
              ),
            ),
          ),
          SliverToBoxAdapter(
            key: _controller.projetosKey,
            child: const SizedBox.shrink(),
          ),
          KpIntro(
            title: 'PROJETOS',
            content:
                'Cases apresentados pelo problema, processo, decisões e resultado — não apenas pelo código.',
          ).buildSliver(context),
          SliverToBoxAdapter(
            child: ScrollReveal(
              child: ProjectsSection(
                sectionPadding: _controller.sectionPadding(context),
              ),
            ),
          ),
          KpIntro(
            title: 'PROCESSO',
            content:
                'Minhas etapas de trabalho, da concepção com metodologias ágeis (Scrum/Kanban) até a entrega final.',
          ).buildSliver(context),
          SliverToBoxAdapter(
            child: ScrollReveal(
              child: ProcessSection(
                sectionPadding: _controller.sectionPadding(context),
              ),
            ),
          ),
          SliverToBoxAdapter(
            key: _controller.contatoKey,
            child: const ScrollReveal(child: ContactSection()),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 70)),
          SliverToBoxAdapter(
            child: ScrollReveal(
              child: Center(
                child: Text(
                  '© 2026 ${PortfolioData.name} • Flutter Developer',
                  style: TextStyle(color: context.onSurfaceVariantColor),
                ),
              ),
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 30)),
        ],
      ),
    ),
  );
}
