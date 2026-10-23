import 'package:flutter/material.dart';
import 'package:kainato_portfolio/app/home/home_controller.dart';

import '../../core/routes/kp_routes.dart';
import '../../widgets/base/kp_intro.dart';
import '../../widgets/base/scroll_reveal.dart';
import '../../widgets/layout/kp_scaffold.dart';
import 'sections/about_section.dart';
import 'sections/contact_section.dart';
import 'sections/hero_section.dart';
import 'sections/projects_section.dart';
import 'sections/skills_section.dart';

/// Página inicial que reúne as seções do portfólio em uma lista rolável.
///
/// Parâmetros: esta página não recebe parâmetros além da chave padrão do Flutter.
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

/// Mantém o controlador de navegação entre as seções da página inicial.
///
/// Parâmetros: esta classe de estado não recebe parâmetros.
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
            content:
                '"A arte de fazer o complexo parecer fácil no primeiro clique"',
            italicContent: true,
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
          SliverToBoxAdapter(
            key: _controller.contatoKey,
            child: const ScrollReveal(child: ContactSection()),
          ),
        ],
      ),
    ),
  );
}
