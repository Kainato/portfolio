import 'package:flutter/material.dart';

/// Botão de navegação exibido para uma seção na barra superior.
///
/// Parâmetros:
/// - `label`: texto visível no botão.
/// - `onSectionTap`: ação executada quando o botão é acionado.
class KpAppbarAction extends StatelessWidget {
  /// Rótulo da seção representada pelo botão de ação.
  final String label;

  /// Callback acionado quando a seção é tocada.
  final VoidCallback onSectionTap;

  /// `KpAppbarAction` é um widget exclusivo de botão de ação no app bar que representa uma seção específica, permitindo que o usuário navegue para essa seção ao ser pressionado.
  ///
  /// ### Parâmetros
  /// - `label`: O rótulo da seção.
  /// - `onSectionTap`: Callback acionado quando a seção é tocada.
  const KpAppbarAction({
    super.key,
    required this.label,
    required this.onSectionTap,
  });

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      label: 'Ir para a seção $label',
      child: TextButton(
        style: TextButton.styleFrom(
          enabledMouseCursor: SystemMouseCursors.click,
        ),
        onPressed: onSectionTap,
        child: Text(label),
      ),
    );
  }
}
