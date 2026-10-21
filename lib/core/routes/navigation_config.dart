import 'package:flutter/material.dart';

import 'kp_routes.dart';

/// Representa um item de navegação do aplicativo.
///
/// *Esta classe encapsula as configurações de um item de navegação que pode
/// ser tanto uma rota interna quanto um link externo. Cada item é totalmente
/// configurável através de suas propriedades, permitindo flexibilidade na
/// construção da interface de navegação.
///
/// Os itens são utilizados para construir a navegação do app, incluindo
/// componentes como `AppBar` e `Drawer`.
///
/// ***Nota:** Não instancie esta classe diretamente. Use [NavigationConfig]
/// para acessar e gerenciar todos os itens de navegação da aplicação.*
class NavigationItem {
  /// Identificador único do item de navegação. Deve ser único dentro de toda a aplicação.
  final String id;

  /// Rótulo exibido para o item de navegação. Geralmente usado como texto visível no `AppBar` ou `Drawer`.
  final String label;

  /// Ícone associado ao item de navegação apresentado no `Drawer` ao lado do rótulo (`label`).
  final IconData icon;

  /// Caminho da rota interna do aplicativo, se aplicável.
  ///
  /// Adicionar um valor para esta variável altera o valor booleano de `isRoute`, que indica se o item de navegação é uma rota interna ou não.
  ///
  /// ### Exemplo de uso
  /// ```dart
  /// final item = NavigationItem(
  ///   id: 'exemplo',
  ///   label: 'Exemplo',
  ///   icon: Icons.home,
  ///   routePath: '/exemplo',
  ///   semanticLabel: 'Ir para a página Exemplo',
  /// );
  /// print(item.isRoute); // true
  /// ```
  final String? routePath;

  /// URL externa, se aplicável. Geralmente usado para links que abrem em um navegador externo.
  ///
  /// Adicionar um valor para esta variável altera o valor booleano de `isExternal`, que indica se o item de navegação é um link externo ou não.
  ///
  /// ### Exemplo de uso
  /// ```dart
  /// final item = NavigationItem(
  ///   id: 'exemplo',
  ///   label: 'Exemplo',
  ///   icon: Icons.link,
  ///   externalUrl: 'https://exemplo.com',
  ///   semanticLabel: 'Abrir exemplo',
  /// );
  /// print(item.isExternal); // true
  /// ```
  final String? externalUrl;

  /// Rótulo semântico para acessibilidade. Geralmente usado por leitores de tela para descrever a ação do item de navegação.
  final String semanticLabel;

  const NavigationItem({
    required this.id,
    required this.label,
    required this.icon,
    required this.semanticLabel,
    this.routePath,
    this.externalUrl,
  });

  /// Verifica se o item de navegação é uma rota interna.
  ///
  /// Retorna `true` se `routePath` não for nulo, indicando que o item é uma rota interna. Caso contrário, retorna `false`.
  bool get isRoute => routePath != null;

  /// Verifica se o item de navegação é um link externo.
  ///
  /// Retorna `true` se `externalUrl` não for nulo, indicando que o item é um link externo. Caso contrário, retorna `false`.
  bool get isExternal => externalUrl != null;
}

/// Configuração centralizada de navegação para toda a aplicação.
/// Ela define os itens de navegação principais exibidos no `AppBar` e `Drawer`,
/// bem como os itens de rota disponíveis no aplicativo com auxílio da padronização das classes `NavigationItem` e `KpRoutes`.
///
/// ### Funcionalidades
/// - `mainItems`: Lista de itens de navegação principais exibidos no `AppBar` e `Drawer`.
class NavigationConfig {
  /// Lista de itens de navegação principais exibidos no `AppBar` e `Drawer`.
  /// Cada item é uma instância de `NavigationItem` contendo informações como:
  /// - `id`
  /// - `label`
  /// - `icon`
  /// - `routePath` ou `externalUrl` (Nunca use ambos ao mesmo tempo)
  /// - `semanticLabel`
  static List<NavigationItem> mainItems = [
    NavigationItem(
      id: 'sobre',
      label: 'Sobre',
      icon: Icons.person,
      routePath: KpRoutes.home.path,
      semanticLabel: 'Ir para a seção Sobre',
    ),
    NavigationItem(
      id: 'habilidades',
      label: 'Habilidades',
      icon: Icons.code,
      routePath: KpRoutes.home.path,
      semanticLabel: 'Ir para a seção Habilidades',
    ),
    NavigationItem(
      id: 'projetos',
      label: 'Projetos',
      icon: Icons.work,
      routePath: KpRoutes.home.path,
      semanticLabel: 'Ir para a seção Projetos',
    ),
    NavigationItem(
      id: 'contato',
      label: 'Contato',
      icon: Icons.email,
      routePath: KpRoutes.home.path,
      semanticLabel: 'Ir para a seção Contato',
    ),
    NavigationItem(
      id: 'certificados',
      label: 'Certificados',
      icon: Icons.verified,
      externalUrl:
          'https://www.linkedin.com/in/kainato/details/certifications/',
      semanticLabel: 'Abrir certificações no LinkedIn',
    ),
  ];
}
