import 'package:flutter/material.dart';

import '../../core/routes/navigation_config.dart';
import '../../core/extension/context_extension.dart';
import '../../core/routes/kp_routes.dart';
import '../../core/utils/kp_launcher.dart';
import '../base/kp_appbar_action.dart';
import '../base/theme_mode_menu.dart';

/// Barra superior com identidade do portfólio, navegação desktop e controle de tema.
///
/// Parâmetros:
/// - `currentRoute`: rota atual usada como contexto de navegação.
/// - `onSectionTap`: callback executado ao selecionar uma seção interna.
class KpAppBar extends StatelessWidget implements PreferredSizeWidget {
  /// A rota (página) atual exibida no app bar.
  final KpRoutes currentRoute;

  /// Callback acionado quando uma seção é tocada no app bar.
  final void Function(String sectionId)? onSectionTap;

  /// `KpAppBar` é um widget de app bar personalizado que exibe o título do portfólio e seções de navegação.
  ///
  /// ### Parâmetros
  /// - `currentRoute`: A página (rota) atual.
  /// - `onSectionTap`: Callback acionado quando uma seção é tocada.
  const KpAppBar({
    super.key,
    this.currentRoute = KpRoutes.home,
    this.onSectionTap,
  });

  @override
  Widget build(BuildContext context) {
    final bool isMobile = context.isMobile;

    return AppBar(
      leading: isMobile
          ? Builder(
              builder: (context) => IconButton(
                tooltip: 'Abrir menu de navegação',
                icon: const Icon(Icons.menu),
                onPressed: Scaffold.of(context).openDrawer,
              ),
            )
          : null,
      title: const Text('Caio Calado'),
      actions: [
        if (!isMobile) ...[
          for (final item in NavigationConfig.mainItems)
            KpAppbarAction(
              label: item.label,
              onSectionTap: () => _handleSectionTap(context, item),
            ),
          const SizedBox(width: 8),
        ],
        const ThemeModeMenu(),
        const SizedBox(width: 8),
      ],
    );
  }

  void _handleSectionTap(BuildContext context, NavigationItem item) {
    if (item.isExternal) {
      openExternalUrl(context, item.externalUrl!);
    } else {
      onSectionTap?.call(item.id);
    }
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
