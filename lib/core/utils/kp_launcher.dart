import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../widgets/dialogs/kp_alert_dialog.dart';
import '../localization/app_language.dart';

/// Abre uma URL externa (http, mailto, tel) em uma aba/app dedicado.
/// Exibe um [KpAlertDialog] caso a operação de abertura falhe.
Future<void> openExternalUrl(BuildContext context, String url) async {
  final uri = Uri.tryParse(url);
  var success = false;
  if (uri != null) {
    try {
      success = await launchUrl(uri, mode: LaunchMode.externalApplication);
    } catch (_) {
      success = false;
    }
  }
  if (!success && context.mounted) {
    await showKpAlertDialog(
      context: context,
      title: tr('Não foi possível abrir o link'),
      content: tr('Confira sua conexão com a internet e tente novamente.'),
      icon: Icons.error_outline,
      confirmLabel: tr('Ok'),
      showCancelButton: false,
    );
  }
}
