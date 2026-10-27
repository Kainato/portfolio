import 'package:flutter/material.dart';
import 'package:kainato_portfolio/core/extension/context_extension.dart';

/// Diálogo de alerta Material 3 com conteúdo e ações configuráveis.
///
/// Parâmetros:
/// - `title`: título opcional mostrado no diálogo.
/// - `content`: mensagem opcional apresentada ao usuário.
/// - `contentWidget`: conteúdo personalizado para layouts mais ricos.
/// - `icon`: ícone opcional exibido acima do título.
/// - `iconColor`: cor opcional aplicada ao ícone.
/// - `confirmLabel`: texto do botão de confirmação.
/// - `cancelLabel`: texto do botão de cancelamento.
/// - `onConfirm`: ação executada após confirmar.
/// - `onCancel`: ação executada após cancelar.
/// - `barrierDismissible`: permite fechar o diálogo tocando fora dele.
/// - `showCancelButton`: controla se o botão de cancelamento é exibido.
/// - `size`: limites máximos opcionais de largura e altura. O diálogo continua
///   ajustando a altura ao conteúdo até alcançar esses limites.
class KpAlertDialog extends StatelessWidget {
  /// Título do diálogo
  final String? title;

  /// Conteúdo principal do diálogo
  final String? content;

  /// Conteúdo personalizado do diálogo. Quando informado, substitui [content].
  final Widget? contentWidget;

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

  /// Limites máximos do diálogo. A altura permanece ajustada ao conteúdo.
  final Size? size;

  const KpAlertDialog({
    super.key,
    this.title,
    this.content,
    this.contentWidget,
    this.icon,
    this.iconColor,
    this.confirmLabel = 'Confirmar',
    this.cancelLabel = 'Cancelar',
    this.onConfirm,
    this.onCancel,
    this.barrierDismissible = true,
    this.showCancelButton = true,
    this.size,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      constraints: BoxConstraints(
        minWidth: (size?.width ?? 280).clamp(0.0, 280.0).toDouble(),
        maxWidth: size?.width ?? double.infinity,
        maxHeight: size?.height ?? double.infinity,
      ),
      icon: icon != null
          ? Icon(icon, color: iconColor ?? context.primaryColor, size: 32.0)
          : null,
      title: title != null ? Text(title!, style: context.headlineSmall) : null,
      content:
          contentWidget ??
          (content != null ? Text(content!, style: context.bodyMedium) : null),
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
  Widget? contentWidget,
  IconData? icon,
  Color? iconColor,
  String confirmLabel = 'Confirmar',
  String cancelLabel = 'Cancelar',
  VoidCallback? onConfirm,
  VoidCallback? onCancel,
  bool barrierDismissible = true,
  bool showCancelButton = true,
  Size? size,
}) {
  return showDialog(
    context: context,
    barrierDismissible: barrierDismissible,
    builder: (context) => KpAlertDialog(
      title: title,
      content: content,
      contentWidget: contentWidget,
      icon: icon,
      iconColor: iconColor,
      confirmLabel: confirmLabel,
      cancelLabel: cancelLabel,
      onConfirm: onConfirm,
      onCancel: onCancel,
      barrierDismissible: barrierDismissible,
      showCancelButton: showCancelButton,
      size: size,
    ),
  );
}
