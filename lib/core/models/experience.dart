/// Destaque ou realização associada a uma experiência profissional.
///
/// Parâmetros:
/// - `title`: título curto do resultado.
/// - `description`: descrição do resultado alcançado.
class ExperienceHighlight {
  final String title;
  final String description;

  const ExperienceHighlight({required this.title, required this.description});
}

/// Dados de uma experiência profissional listada no currículo.
///
/// Parâmetros:
/// - `company`: nome da empresa.
/// - `role`: cargo exercido.
/// - `period`: período de atuação.
/// - `highlights`: lista de resultados e destaques da experiência.
class Experience {
  final String company;
  final String role;
  final String period;
  final List<ExperienceHighlight> highlights;

  const Experience({
    required this.company,
    required this.role,
    required this.period,
    required this.highlights,
  });
}
