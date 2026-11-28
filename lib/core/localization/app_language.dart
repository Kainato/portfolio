import 'package:flutter/foundation.dart';

enum AppLanguage { ptBr, enUs }

class AppLanguageController extends ChangeNotifier {
  AppLanguageController._() : _language = _resolveInitialLanguage();
  static final instance = AppLanguageController._();
  AppLanguage _language;
  AppLanguage get language => _language;
  bool get isEnglish => _language == AppLanguage.enUs;

  static AppLanguage _resolveInitialLanguage() {
    for (final locale in PlatformDispatcher.instance.locales) {
      final languageCode = locale.languageCode.toLowerCase();

      if (languageCode == 'en') return AppLanguage.enUs;
      if (languageCode == 'pt') return AppLanguage.ptBr;
    }

    return AppLanguage.ptBr;
  }

  void setLanguage(AppLanguage language) {
    if (_language == language) return;
    _language = language;
    notifyListeners();
  }
}

/// English translations for the portfolio's Portuguese source copy.
String tr(String source) => AppLanguageController.instance.isEnglish
    ? (_english[source] ?? source)
    : source;

const Map<String, String> _english = {
  'Skills': 'Skills',
  'Explore o portfólio em uma interface interativa inspirada em RPG.':
      'Explore the portfolio through an interactive RPG-inspired interface.',
  'Experiência de trabalho': 'Professional experience',
  'Produtos e entregas desenvolvidos em contextos profissionais.':
      'Products and work delivered in professional settings.',
  'Laboratório de programação': 'Programming lab',
  'Projetos próprios para estudo, experimentação e compartilhamento.':
      'Personal projects for study, experimentation, and sharing.',
  'Copiar e-mail': 'Copy email',
  'E-mail copiado para a área de transferência.': 'Email copied to clipboard.',
  'Voltar à página anterior': 'Go back to the previous page',
  'Voltar': 'Back',
  'Imagens do projeto serão adicionadas aqui.':
      'Project images will be added here.',
  'Abrir link externo': 'Open external link',
  'Não foi possível carregar os detalhes deste projeto.':
      'Could not load this project’s details.',
  'Voltar ao portfólio': 'Back to portfolio',
  'E-mail': 'Email',
  'Nível = anos de carreira desde Fev/2020.':
      'Level = years in the career since Feb/2020.',
  'Disponibilidade para novas propostas. 100/100 = disponível agora.':
      'Availability for new opportunities. 100/100 = available now.',
  'Progresso até completar mais um ano de experiência. Cada ano de carreira = 1 nível.':
      'Progress until another year of experience. Each career year = 1 level.',
  'Sobre': 'About',
  'Habilidades': 'Skills',
  'Projetos': 'Projects',
  'Contato': 'Contact',
  'Certificados': 'Certificates',
  'Ir para a seção Sobre': 'Go to the About section',
  'Ir para a seção Habilidades': 'Go to the Skills section',
  'Ir para a seção Projetos': 'Go to the Projects section',
  'Ir para a seção Contato': 'Go to the Contact section',
  'Abrir certificações no LinkedIn': 'Open certifications on LinkedIn',
  'Conecte-se Comigo': 'Connect with me',
  'Abrir menu de navegação': 'Open navigation menu',
  'Selecionar idioma': 'Select language',
  'Português (Brasil)': 'Portuguese (Brazil)',
  'Inglês (EUA)': 'English (US)',
  'SOBRE MIM': 'ABOUT ME',
  'HABILIDADES': 'SKILLS',
  'PROJETOS': 'PROJECTS',
  'Tecnologias, linguagens, frameworks e ferramentas que domino e utilizo no dia a dia.':
      'Technologies, languages, frameworks, and tools I master and use every day.',
  'Cases apresentados pelo problema, processo, decisões e resultado — não apenas pelo código.':
      'Case studies presented through the problem, process, decisions, and outcome—not just the code.',
  'Transformo processos complexos em produtos digitais simples de usar.':
      'I turn complex processes into digital products that are simple to use.',
  'DESENVOLVEDOR FLUTTER SÊNIOR · MOBILE & WEB':
      'SENIOR FLUTTER DEVELOPER · MOBILE & WEB',
  'Desenvolvedor Flutter Sênior': 'Senior Flutter Developer',
  'Trabalho com Flutter em produtos mobile e web, da arquitetura à interface, conectando necessidades reais de negócio a experiências claras e confiáveis.':
      'I work with Flutter on mobile and web products, from architecture to interface, connecting real business needs with clear and reliable experiences.',
  'Ver mais e ir para a seção de projetos':
      'See more and go to the Projects section',
  'Ver projetos': 'View projects',
  'Abrir perfil no GitHub em uma nova aba': 'Open GitHub profile in a new tab',
  'Abrir perfil no LinkedIn em uma nova aba':
      'Open LinkedIn profile in a new tab',
  'Foto de Caio Calado de Araújo': 'Photo of Caio Calado de Araújo',
  'anos com Flutter': 'years with Flutter',
  'redes atendidas': 'clinic networks served',
  'sistemas unificados': 'systems unified',
  'Sou desenvolvedor Flutter Sênior, com ':
      'I am a Senior Flutter Developer with ',
  'mais de 6 anos de experiência': 'over 6 years of experience',
  ' criando aplicações mobile e web. Na TiTa Therapy, construí e mantive uma plataforma usada diariamente por ':
      ' building mobile and web applications. At TiTa Therapy, I built and maintained a platform used daily by ',
  'mais de 10 redes de clínicas': 'more than 10 clinic networks',
  '. Na Amigo Tech / Clínica Mundos, colaborei com a Teatech para digitalizar processos e unificar ':
      '. At Amigo Tech / Clínica Mundos, I collaborated on Teatech to digitize processes and unify ',
  '3 sistemas legados': '3 legacy systems',
  '. Também trabalho com arquitetura reativa, integração via APIs REST, publicação nas lojas e gestão ágil de projetos.':
      '. I also work with reactive architecture, REST API integration, app store releases, and agile project management.',
  'VAMOS CONVERSAR?': "LET'S TALK",
  'Tem um projeto interessante?': 'Have an interesting project?',
  'Abrir ': 'Open ',
  'Ver detalhes': 'View details',
  'Repositório': 'Repository',
  'Ver case': 'View case',
  'Contexto e desafio': 'Context and challenge',
  'Solução': 'Solution',
  'Impacto': 'Impact',
  'Tecnologias': 'Technologies',
  'Fechar': 'Close',
  'Mobile & Frontend': 'Mobile & Frontend',
  'Desenvolvimento multiplataforma e interfaces modernas':
      'Cross-platform development and modern interfaces',
  'Backend & Dashboards': 'Backend & Dashboards',
  'Servidores, APIs e painéis administrativos':
      'Servers, APIs, and admin dashboards',
  'Dados & Cloud': 'Data & Cloud',
  'Armazenamento, autenticação e infraestrutura em nuvem':
      'Storage, authentication, and cloud infrastructure',
  'Publicação & Ferramentas': 'Delivery & Tools',
  'Versionamento, CI/CD e ferramentas de desenvolvimento':
      'Version control, CI/CD, and development tools',
  'Digitalização e Unificação de Processos':
      'Process Digitization and Unification',
  'Desenvolvimento Mobile Flutter': 'Flutter Mobile Development',
  'Gestão Ágil e Liderança': 'Agile Management and Leadership',
  'Desenvolvimento Cross-Platform': 'Cross-Platform Development',
  'Arquitetura & Engenharia': 'Architecture & Engineering',
  'Publicação & DevOps Mobile': 'Mobile Release & DevOps',
  'UI/UX Design & Prototipagem': 'UI/UX Design & Prototyping',
  'Teatec — Amigo Tech & Clínica Mundos':
      'Teatec — Amigo Tech & Clínica Mundos',
  'Plataforma web para digitalizar processos e unificar sistemas da Clínica Mundos.':
      'Web platform to digitize processes and unify Clínica Mundos systems.',
  'Na atuação junto à Amigo Tech e à Clínica Mundos, colaborei no desenvolvimento da Teatec, migrando processos em papel e centralizando 3 sistemas antigos em uma única solução. A unificação acelerou a geração de relatórios e métricas da clínica.':
      'While working with Amigo Tech and Clínica Mundos, I contributed to Teatec, migrating paper processes and consolidating 3 legacy systems into one solution. This unification sped up the clinic’s reports and metrics.',
  'Processos em papel e informações distribuídas em três sistemas antigos dificultavam a operação e a geração de relatórios.':
      'Paper processes and information spread across three legacy systems made operations and reporting difficult.',
  'Colaboração no desenvolvimento de uma plataforma web que centralizou os sistemas e digitalizou os processos da clínica.':
      'Contributed to a web platform that centralized the systems and digitized clinic processes.',
  'A centralização acelerou a geração de relatórios e métricas para a Clínica Mundos.':
      'Centralization sped up reporting and metrics for Clínica Mundos.',
  'App Corporativo — Clínica Mundos': 'Corporate App — Clínica Mundos',
  'Aplicativo mobile das filiais integrado à plataforma Teatech.':
      'Mobile app for branch offices integrated with the Teatech platform.',
  'Na Amigo Tech / Clínica Mundos, construí e implementei funcionalidades mobile para o aplicativo corporativo usado pelas filiais. A integração com a Teatech é feita via APIs REST, com GetX para gerenciamento de estado e navegação.':
      'At Amigo Tech / Clínica Mundos, I built and implemented mobile features for the corporate app used by branch offices. It integrates with Teatech through REST APIs, using GetX for state management and navigation.',
  'Plataforma cross-platform para redes de clínicas de terapia.':
      'Cross-platform platform for therapy clinic networks.',
  'Construção e manutenção da plataforma principal da startup para mobile e web, usada diariamente por mais de 10 redes de clínicas e suas filiais. Arquitetura reativa com MobX e Provider, integração com APIs REST e publicação nas lojas Google Play e App Store.':
      'Built and maintained the startup’s main mobile and web platform, used daily by more than 10 clinic networks and their branches. Reactive architecture with MobX and Provider, REST API integration, and releases on Google Play and the App Store.',
  'Manter uma plataforma de atendimento usada diariamente por múltiplas redes de clínicas em dispositivos móveis e web.':
      'Maintain a care platform used daily by multiple clinic networks on mobile and web.',
  'Construção e manutenção do produto cross-platform em Flutter, com arquitetura reativa, integração REST e rotinas de publicação nas lojas.':
      'Built and maintained the cross-platform Flutter product with reactive architecture, REST integration, and app store release workflows.',
  'A plataforma atendia mais de 10 redes de clínicas e suas filiais.':
      'The platform served more than 10 clinic networks and their branches.',
  'Laboratório de programação dedicado a algoritmos, estruturas de dados e performance em Dart.':
      'Programming lab focused on algorithms, data structures, and Dart performance.',
  'Ambiente de pesquisa e prática em engenharia de software no ecossistema Dart, com implementações de algoritmos avançados e estruturas de dados otimizadas.':
      'A software engineering research and practice environment in the Dart ecosystem, with advanced algorithm implementations and optimized data structures.',
  'Plataforma de documentação técnica que organiza cursos, aprendizados e boas práticas.':
      'Technical documentation platform organizing courses, learnings, and best practices.',
  'Documentação escalável publicada em produção para catalogar cursos, aprendizados, notas de desenvolvimento e boas práticas. O versionamento segue conceitos de GitOps.':
      'Scalable production documentation for cataloging courses, learnings, development notes, and best practices. Versioning follows GitOps concepts.',
  'Este portfólio': 'This portfolio',
  'Portfólio profissional responsivo que reúne trajetória, projetos e métricas de impacto.':
      'Responsive professional portfolio bringing together career history, projects, and impact metrics.',
  'Aplicação web responsiva desenvolvida para centralizar o histórico profissional, os projetos e seus resultados, com publicação contínua via GitHub Pages.':
      'Responsive web app built to bring together professional history, projects, and outcomes, with continuous publishing through GitHub Pages.',
  'Não foi possível abrir o link': 'Unable to open link',
  'Confira sua conexão com a internet e tente novamente.':
      'Check your internet connection and try again.',
  '"A arte de fazer o complexo parecer fácil no primeiro clique"':
      '“The art of making the complex feel easy from the very first click.”',
  'Abrir referência sobre ': 'Open reference for ',
  'Claro': 'Light',
  'Escuro': 'Dark',
  'Sistema': 'System',
  'Tema': 'Theme',
  'Selecionar tema': 'Select theme',
  'Abrir opções de tema': 'Open theme options',
  'Tema atual: ': 'Current theme: ',
  'Ok': 'OK',
  'Digitalização de processos': 'Process digitization',
  'Algoritmos': 'Algorithms',
  'Estruturas de dados': 'Data structures',
  'Nov/2024 – Mai/2026': 'Nov 2024 – May 2026',
  'Fev/2020 – Nov/2024': 'Feb 2020 – Nov 2024',
};
