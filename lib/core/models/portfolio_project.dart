/// Dados de um projeto ou case exibido no portfólio.
///
/// Parâmetros:
/// - `order`: marcador de ordem exibido no cartão.
/// - `title`: nome do projeto.
/// - `subtitle`: resumo curto do projeto.
/// - `stack`: tecnologias usadas no projeto.
/// - `description`: detalhes do problema e da solução.
/// - `url`: endereço opcional para abrir o projeto ou case.
class PortfolioProject {
  final String order;
  final String title;
  final String subtitle;
  final String stack;
  final String description;
  final String? url;

  const PortfolioProject({
    required this.order,
    required this.title,
    required this.subtitle,
    required this.stack,
    required this.description,
    this.url,
  });
}
