import 'package:flutter/material.dart';

import '../../core/extension/context_extension.dart';

/// Controla a rolagem e o espaçamento responsivo das seções da página inicial.
///
/// Parâmetros: esta classe não recebe parâmetros.
class HomeController {
  /// Controlador da página inicial, responsável por gerenciar a navegação entre seções.
  HomeController();

  /// Chave global para a seção "Sobre mim".
  /// Utilizada para rolar para a seção correspondente quando necessário.
  final GlobalKey<State<StatefulWidget>> sobreKey = GlobalKey();

  /// Chave global para a seção "Habilidades".
  /// Utilizada para rolar para a seção correspondente quando necessário.
  final GlobalKey<State<StatefulWidget>> habilidadesKey = GlobalKey();

  /// Chave global para a seção "Projetos".
  /// Utilizada para rolar para a seção correspondente quando necessário.
  final GlobalKey<State<StatefulWidget>> projetosKey = GlobalKey();

  /// Chave global para a seção "Contato".
  /// Utilizada para rolar para a seção correspondente quando necessário.
  final GlobalKey<State<StatefulWidget>> contatoKey = GlobalKey();

  /// Rola para a seção correspondente com base no ID fornecido.
  ///
  /// Os IDs válidos são:
  /// - 'sobre': Seção "Sobre mim"
  /// - 'habilidades': Seção "Habilidades"
  /// - 'projetos': Seção "Projetos"
  /// - 'contato': Seção "Contato"
  void scrollToSection(String id) {
    final key = switch (id) {
      'sobre' => sobreKey,
      'habilidades' => habilidadesKey,
      'projetos' => projetosKey,
      'contato' => contatoKey,
      _ => null,
    };
    final sectionContext = key?.currentContext;
    if (sectionContext != null) {
      Scrollable.ensureVisible(
        sectionContext,
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    }
  }

  /// Retorna o padding horizontal padrão para as seções da página inicial.
  /// Ajusta o valor com base no tamanho da tela (mobile ou desktop).
  EdgeInsets sectionPadding(BuildContext context) =>
      EdgeInsets.symmetric(horizontal: context.isMobile ? 20 : 32);
}
