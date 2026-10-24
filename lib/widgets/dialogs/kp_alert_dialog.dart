import 'package:flutter/material.dart';
import 'package:kainato_portfolio/core/extension/context_extension.dart';

/// Diálogo de alerta Material 3 com conteúdo e ações configuráveis.
///
/// Parâmetros:
/// - `title`: título opcional mostrado no diálogo.
/// - `content`: mensagem opcional apresentada ao usuário.
/// - `icon`: ícone opcional exibido acima do título.
/// - `iconColor`: cor opcional aplicada ao ícone.
/// - `confirmLabel`: texto do botão de confirmação.
/// - `cancelLabel`: texto do botão de cancelamento.
/// - `onConfirm`: ação executada após confirmar.
/// - `onCancel`: ação executada após cancelar.
/// - `barrierDismissible`: permite fechar o diálogo tocando fora dele.
/// - `showCancelButton`: controla se o botão de cancelamento é exibido.
class KpAlertDialog extends StatelessWidget {
  /// Título do diálogo
  final String? title;

  /// Conteúdo principal do diálogo
  final String? content;

  /// Ícone exibido no topo do diálogo
  final IconData? icon;

  /// Cor do ícone
  final Color? iconColor;

  /// Rótulo do botão de confirmação
  final String confirmLabel;

  /// Rótulo do botão de cancelamento
  final String cancelLabel;

  /// Callback executado ao confirmar
  final VoidCallback? onConfirm;

  /// Callback executado ao cancelar
  final VoidCallback? onCancel;

  /// Define se o diálogo deve fechar ao clicar fora dele
  final bool barrierDismissible;

  /// Exibe o botão de cancelamento. Defina como `false` para diálogos apenas informativos.
  final bool showCancelButton;

  const KpAlertDialog({
    super.key,
    this.title,
    this.content,
    this.icon,
    this.iconColor,
    this.confirmLabel = 'Confirmar',
    this.cancelLabel = 'Cancelar',
    this.onConfirm,
    this.onCancel,
    this.barrierDismissible = true,
    this.showCancelButton = true,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      icon: icon != null
          ? Icon(icon, color: iconColor ?? context.primaryColor, size: 32.0)
          : null,
      title: title != null ? Text(title!, style: context.headlineSmall) : null,
      content: content != null
          ? Text(content!, style: context.bodyMedium)
          : null,
      actions: [
        if (showCancelButton)
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              onCancel?.call();
            },
            child: Text(cancelLabel),
          ),
        FilledButton(
          onPressed: () {
            Navigator.of(context).pop();
            onConfirm?.call();
          },
          child: Text(confirmLabel),
        ),
      ],
    );
  }
}

/// Função auxiliar para mostrar o KpAlertDialog
Future<void> showKpAlertDialog({
  required BuildContext context,
  String? title,
  String? content,
  IconData? icon,
  Color? iconColor,
  String confirmLabel = 'Confirmar',
  String cancelLabel = 'Cancelar',
  VoidCallback? onConfirm,
  VoidCallback? onCancel,
  bool barrierDismissible = true,
  bool showCancelButton = true,
}) {
  return showDialog(
    context: context,
    barrierDismissible: barrierDismissible,
    builder: (context) => KpAlertDialog(
      title: title,
      content: content,
      icon: icon,
      iconColor: iconColor,
      confirmLabel: confirmLabel,
      cancelLabel: cancelLabel,
      onConfirm: onConfirm,
      onCancel: onCancel,
      barrierDismissible: barrierDismissible,
      showCancelButton: showCancelButton,
    ),
  );
}
