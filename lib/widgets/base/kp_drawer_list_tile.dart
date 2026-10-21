import 'package:flutter/material.dart';

class KpDrawerListTile extends StatelessWidget {
  /// Indica se o item está selecionado.
  final bool selected;

  /// O texto exibido no item.
  final String label;

  /// O rótulo semântico (ajuda) do item.
  final String semanticLabel;

  /// O ícone exibido no item.
  final IconData icon;

  /// Callback acionado quando o item é tocado.
  final VoidCallback onTap;

  /// `KpDrawerListTile` é um widget exclusivo de item de drawer personalizado que exibe um ícone, um rótulo e suporta seleção e ação de toque.
  ///
  /// ### Parâmetros
  /// - `selected`: Indica se o item está selecionado.
  /// - `label`: O texto exibido no item.
  /// - `semanticLabel`: O rótulo semântico do item.
  /// - `icon`: O ícone exibido no item.
  /// - `onTap`: Callback acionado quando o item é tocado.
  const KpDrawerListTile({
    super.key,
    required this.selected,
    required this.label,
    required this.semanticLabel,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: Semantics(
        button: true,
        selected: selected,
        label: semanticLabel,
        child: ListTile(
          leading: Icon(icon),
          title: Text(label),
          selected: selected,
          onTap: onTap,
        ),
      ),
    );
  }
}
