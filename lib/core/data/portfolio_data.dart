import 'package:flutter/material.dart';

import '../models/certificate.dart';
import '../models/experience.dart';
import '../models/portfolio_project.dart';
import '../models/skill.dart';
import '../models/skill_category.dart';

/// Fonte central de dados usados pelas telas do projeto.
///
/// Essas informações são utilizadas para popular as diferentes seções do aplicativo e raramente precisam ser alteradas, apenas quando há atualizações relevantes no portfólio ou nos dados pessoais do desenvolvedor.
///
/// Parâmetros: esta classe de dados não recebe parâmetros.
abstract final class PortfolioData {
  // Meu nome
  static const String name = 'Caio Calado';
  // Meu cargo profissional
  static const String role = 'Desenvolvedor Flutter Sênior';
  // Minha tagline profissional
  static const String tagline = 'FLUTTER • MOBILE • UI/UX';

  // Descrição exibida na seção hero do aplicativo
  static const String heroDescription =
      'Desenvolvedor Flutter apaixonado por criar soluções digitais que unem tecnologia, '
      'clareza e uma boa experiência para quem usa.';

  // Descrição exibida na seção "Sobre" do aplicativo
  static const String about =
      'Desenvolvedor Frontend focado em Flutter & Dart com mais de 6 anos de experiência no '
      'desenvolvimento, arquitetura e manutenção de aplicações móveis e web. Ampla vivência na '
      'estruturação de software com Provider, MobX e GetX, consumo de APIs REST e '
      'desenvolvimento de painéis administrativos/backends com Laravel e Filament. Forte atuação '
      'em colaboração com times de UX/UI (Figma), aplicação de metodologias ágeis e publicação '
      'de aplicativos nas lojas.';

  static const List<Skill> skills = [
    Skill(
      name: 'Flutter',
      color: Color(0xFF02569B),
      url: 'https://flutter.dev',
    ),
    Skill(name: 'Dart', color: Color(0xFF0175C2), url: 'https://dart.dev'),
    Skill(
      name: 'Provider',
      color: Color(0xFF13B9FD),
      url: 'https://pub.dev/packages/provider',
    ),
    Skill(
      name: 'MobX',
      color: Color(0xFFFF9955),
      url: 'https://pub.dev/packages/mobx',
    ),
    Skill(
      name: 'GetX',
      color: Color(0xFF8A2BE2),
      url: 'https://pub.dev/packages/get',
    ),
    Skill(
      name: 'REST API',
      color: Color(0xFF6A1B9A),
      url: 'https://restfulapi.net',
    ),
    Skill(
      name: 'Laravel',
      color: Color(0xFFFF2D20),
      url: 'https://laravel.com',
    ),
    Skill(
      name: 'Filament',
      color: Color(0xFFE38A01),
      url: 'https://filamentphp.com',
    ),
    Skill(name: 'PHP', color: Color(0xFF777BB4), url: 'https://www.php.net'),
    Skill(
      name: 'MySQL',
      color: Color(0xFF00758F),
      url: 'https://www.mysql.com',
    ),
    Skill(
      name: 'Firebase',
      color: Color(0xFFFFCA28),
      onColor: Colors.black,
      url: 'https://firebase.google.com',
    ),
    Skill(
      name: 'Supabase',
      color: Color(0xFF3ECF8E),
      onColor: Colors.black,
      url: 'https://supabase.com',
    ),
    Skill(name: 'Git', color: Color(0xFFF05032), url: 'https://git-scm.com'),
    Skill(name: 'GitHub', color: Color(0xFF333333), url: 'https://github.com'),
    Skill(
      name: 'Figma',
      color: Color(0xFFF24E1E),
      url: 'https://www.figma.com',
    ),
  ];

  static const List<SkillCategory> skillsCategories = [
    SkillCategory(
      name: 'Mobile & Frontend',
      description: 'Desenvolvimento multiplataforma e interfaces modernas',
      icon: Icons.phone_iphone_rounded,
      skills: [
        Skill(
          name: 'Flutter',
          color: Color(0xFF02569B),
          url: 'https://flutter.dev',
        ),
        Skill(name: 'Dart', color: Color(0xFF0175C2), url: 'https://dart.dev'),
        Skill(
          name: 'Provider',
          color: Color(0xFF13B9FD),
          url: 'https://pub.dev/packages/provider',
        ),
        Skill(
          name: 'MobX',
          color: Color(0xFFFF9955),
          url: 'https://pub.dev/packages/mobx',
        ),
        Skill(
          name: 'GetX',
          color: Color(0xFF8A2BE2),
          url: 'https://pub.dev/packages/get',
        ),
      ],
    ),
    SkillCategory(
      name: 'Backend & Dashboards',
      description: 'Servidores, APIs e painéis administrativos',
      icon: Icons.storage_rounded,
      skills: [
        Skill(
          name: 'Laravel',
          color: Color(0xFFFF2D20),
          url: 'https://laravel.com',
        ),
        Skill(
          name: 'Filament',
          color: Color(0xFFE38A01),
          url: 'https://filamentphp.com',
        ),
        Skill(
          name: 'PHP',
          color: Color(0xFF777BB4),
          url: 'https://www.php.net',
        ),
        Skill(
          name: 'REST API',
          color: Color(0xFF6A1B9A),
          url: 'https://restfulapi.net',
        ),
        Skill(
          name: 'MySQL',
          color: Color(0xFF00758F),
          url: 'https://www.mysql.com',
        ),
      ],
    ),
    SkillCategory(
      name: 'Dados & Cloud',
      description: 'Armazenamento, autenticação e infraestrutura em nuvem',
      icon: Icons.cloud_rounded,
      skills: [
        Skill(
          name: 'Firebase',
          color: Color(0xFFFFCA28),
          onColor: Colors.black,
          url: 'https://firebase.google.com',
        ),
        Skill(
          name: 'Supabase',
          color: Color(0xFF3ECF8E),
          onColor: Colors.black,
          url: 'https://supabase.com',
        ),
      ],
    ),
    SkillCategory(
      name: 'Publicação & Ferramentas',
      description: 'Versionamento, CI/CD e ferramentas de desenvolvimento',
      icon: Icons.construction_rounded,
      skills: [
        Skill(
          name: 'Git',
          color: Color(0xFFF05032),
          url: 'https://git-scm.com',
        ),
        Skill(
          name: 'GitHub',
          color: Color(0xFF333333),
          url: 'https://github.com',
        ),
        Skill(
          name: 'Figma',
          color: Color(0xFFF24E1E),
          url: 'https://www.figma.com',
        ),
      ],
    ),
  ];

  static const List<Experience> experiences = [
    Experience(
      company: 'Amigo Tech / Clínica Mundos',
      role: 'Desenvolvedor de Software / Gerente de Projetos de TI',
      period: 'Nov/2024 – Mai/2026',
      highlights: [
        ExperienceHighlight(
          title: 'Digitalização e Unificação de Processos',
          description:
              'Colaboração no desenvolvimento da plataforma Teatech (Web/Laravel/Filament PHP), '
              'migrando processos em papel e centralizando 3 sistemas antigos em uma única '
              'solução, acelerando a geração de relatórios e métricas da clínica.',
        ),
        ExperienceHighlight(
          title: 'Desenvolvimento Mobile Flutter',
          description:
              'Construção e implementação de funcionalidades mobile no aplicativo corporativo '
              'das filiais da Clínica Mundos, utilizando GetX para gerenciamento de estado e '
              'navegação, integrado via APIs REST.',
        ),
        ExperienceHighlight(
          title: 'Gestão Ágil e Liderança',
          description:
              'Aplicação de Scrum/Kanban para gestão de sprints, priorização de backlog e '
              'alinhamento do time técnico, atuando como ponte direta entre desenvolvimento e '
              'produto.',
        ),
      ],
    ),
    Experience(
      company: 'TiTa Therapy',
      role: 'Desenvolvedor de Software (Programador de Sistemas)',
      period: 'Fev/2020 – Nov/2024',
      highlights: [
        ExperienceHighlight(
          title: 'Desenvolvimento Cross-Platform',
          description:
              'Construção e manutenção da plataforma principal da startup (mobile e web em '
              'Flutter), atendendo mais de 10 redes de clínicas ativas e suas filiais no uso '
              'diário.',
        ),
        ExperienceHighlight(
          title: 'Arquitetura & Engenharia',
          description:
              'Estruturação da arquitetura reativa utilizando MobX e Provider, garantindo '
              'reutilização de código e performance nas integrações com APIs REST.',
        ),
        ExperienceHighlight(
          title: 'Publicação & DevOps Mobile',
          description:
              'Gerenciamento completo do ciclo de vida das rotinas de release, versionamento '
              '(Git) e publicação/atualizações contínuas nas lojas Google Play e Apple App Store.',
        ),
        ExperienceHighlight(
          title: 'UI/UX Design & Prototipagem',
          description:
              'Atuação híbrida, criando protótipos de alta fidelidade no Figma e implementando '
              'a interface diretamente no Flutter com fidelidade ao layout.',
        ),
      ],
    ),
  ];

  static const List<PortfolioProject> projects = [
    PortfolioProject(
      order: '01',
      title: 'Teatech — Clínica Mundos',
      subtitle:
          'Plataforma web para digitalizar e unificar processos de uma rede de clínicas.',
      stack: 'Laravel • Filament PHP • MySQL',
      description:
          'Migração de processos em papel e centralização de 3 sistemas legados em uma única '
          'solução, acelerando a geração de relatórios e métricas para a operação da clínica.',
    ),
    PortfolioProject(
      order: '02',
      title: 'App Corporativo — Clínica Mundos',
      subtitle:
          'Aplicativo mobile para filiais, com gestão de estado via GetX.',
      stack: 'Flutter • GetX • REST API',
      description:
          'Funcionalidades mobile integradas via API REST para dar suporte ao dia a dia das '
          'filiais, com navegação e estado gerenciados por GetX.',
    ),
    PortfolioProject(
      order: '03',
      title: 'TiTa Therapy',
      subtitle: 'Plataforma cross-platform para redes de clínicas de terapia.',
      stack: 'Flutter • MobX • Provider',
      description:
          'Construção e manutenção da plataforma principal da startup (mobile e web), '
          'atendendo mais de 10 redes de clínicas ativas, com arquitetura reativa e publicação '
          'contínua nas lojas.',
    ),
    PortfolioProject(
      order: '04',
      title: 'Bibliotech',
      subtitle:
          'Projeto que transforma o "cemitério de repositórios" em uma documentação viva que consolida conhecimentos adquiridos.',
      stack: 'TypeScript • Tailwind CSS • Markdown',
      description:
          'Este repositório atua como um hub de conhecimento e referência técnica: '
          'um guia prático para rápida consulta, reutilização de snippets testados e '
          'registro da evolução em diferentes tecnologias e padrões de arquitetura. '
          'O conteúdo é centralizado, com navegação adaptada para desktop e mobile.',
      url: 'https://bibliotech-three.vercel.app/',
    ),
    PortfolioProject(
      order: '05',
      title: 'Este portfólio',
      subtitle:
          'Site pessoal responsivo desenvolvido inteiramente em Flutter Web.',
      stack: 'Flutter Web • Dart',
      description:
          'Vitrine de projetos e experiência profissional, com layout responsivo, tema '
          'centralizado e navegação adaptada para desktop e mobile.',
      url: 'https://github.com/Kainato/kainato_portfolio',
    ),
  ];

  // Dados de exemplo — substituir pelos certificados reais assim que disponíveis.
  static const List<Certificate> certificates = [
    Certificate(
      title: 'Flutter & Dart — Arquitetura e Boas Práticas',
      issuer: 'Instituição de ensino',
      date: '2023',
      verificationUrl: 'https://example.com/certificado/flutter-arquitetura',
    ),
    Certificate(
      title: 'Metodologias Ágeis — Scrum e Kanban',
      issuer: 'Instituição de ensino',
      date: '2022',
      verificationUrl: 'https://example.com/certificado/agile-scrum-kanban',
    ),
    Certificate(
      title: 'Laravel & Filament PHP para Painéis Administrativos',
      issuer: 'Instituição de ensino',
      date: '2024',
      verificationUrl: 'https://example.com/certificado/laravel-filament',
    ),
  ];
}
