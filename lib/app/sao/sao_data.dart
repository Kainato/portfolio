/// Dados exclusivos do modo SAO.
///
/// Tudo que já existe no portfólio (skills, experiências, projetos e
/// certificados) continua vindo de [PortfolioData]. Aqui ficam só as
/// informações de "jogo" que ainda não existem no modelo atual.
abstract final class SaoData {
  // Início da carreira, usado para calcular o nível do jogador
  static final DateTime careerStart = DateTime(2020, 2);

  static double get yearsOfExperience =>
      DateTime.now().difference(careerStart).inDays / 365.25;

  // Nível = anos de experiência + 1 (Fev/2020 → Nov/2026 = LV 7)
  static int get level => yearsOfExperience.floor() + 1;

  // Progresso até o próximo nível (0.0 a 1.0)
  static double get expProgress => yearsOfExperience % 1;

  // Níveis de domínio de 1 a 5 (valores de exemplo, ajuste para os seus)
  static const Map<String, int> skillLevels = {
    'Flutter': 5,
    'Dart': 5,
    'Provider': 4,
    'MobX': 4,
    'GetX': 4,
    'Laravel': 3,
    'Filament': 3,
    'PHP': 3,
    'REST API': 4,
    'MySQL': 3,
    'Firebase': 4,
    'Supabase': 3,
    'Git': 5,
    'GitHub': 5,
    'Figma': 4,
  };

  // Atributos da janela de status (valores de exemplo de 0 a 100)
  static const List<(String, int)> attributes = [
    ('Mobile (Flutter)', 95),
    ('Arquitetura', 85),
    ('UI/UX', 78),
    ('Backend', 62),
    ('Liderança', 70),
  ];

  // Rank de cada missão, indexado pelo campo `order` do projeto
  static const Map<String, String> questRanks = {
    '01': 'S',
    '02': 'A',
    '03': 'S',
    '04': 'B',
    '05': 'B',
    '06': 'A',
  };

  // Marcos reais tirados das experiências
  static const List<SaoMilestone> milestones = [
    SaoMilestone('🏥', '10+ redes de clínicas', 'TiTa Therapy em uso diário'),
    SaoMilestone('📱', 'Publicado em 2 lojas', 'Google Play e App Store'),
    SaoMilestone('🧩', '3 sistemas → 1', 'Unificação na Teatech'),
    SaoMilestone('📚', 'Bibliotech no ar', 'Documentação em produção'),
  ];
}

/// Conquista desbloqueada exibida na janela de conquistas.
class SaoMilestone {
  const SaoMilestone(this.emoji, this.title, this.description);

  final String emoji;
  final String title;
  final String description;
}
