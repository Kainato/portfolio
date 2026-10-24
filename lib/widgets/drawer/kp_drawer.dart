import 'package:flutter/material.dart';
import 'package:kainato_portfolio/widgets/base/kp_drawer_list_tile.dart';

import '../../core/data/contact_link.dart';
import '../../core/data/portfolio_data.dart';
import '../../core/extension/context_extension.dart';
import '../../core/extension/text_extension.dart';
import '../../core/routes/kp_routes.dart';
import '../../core/routes/navigation_config.dart';
import '../../core/utils/kp_launcher.dart';

/// Menu lateral com navegação principal, contatos e acesso às opções de tema.
///
/// Parâmetros:
/// - `route`: rota atual da página que contém o menu.
/// - `onSectionTap`: callback para navegar até uma seção interna.
class KpDrawer extends StatelessWidget {
  /// A página (rota) atual exibida no drawer.
  final KpRoutes route;

  /// Callback acionado quando uma seção é tocada no drawer.
  final void Function(String sectionId)? onSectionTap;

  const KpDrawer({super.key, required this.route, this.onSectionTap});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: ListView(
          children: [
            DrawerHeader(
              child: Center(
                child: Text(PortfolioData.name, style: context.displaySmall),
              ),
            ),
            for (final item in NavigationConfig.mainItems)
              KpDrawerListTile(
                semanticLabel: item.semanticLabel,
                selected: false,
                label: item.label,
                icon: item.icon,
                onTap: () => _handleItemTap(context, item),
              ),
            const Divider(),
            Text("Conecte-se Comigo", style: context.titleMedium).padding(
              const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
            ),
            for (final link in ContactLink.contactLinks)
              KpDrawerListTile(
                semanticLabel: 'Abrir ${link.label}: ${link.value}',
                selected: false,
                label: link.value,
                icon: link.icon,
                onTap: () {
                  Navigator.pop(context);
                  openExternalUrl(context, link.url);
                },
              ),
          ],
        ),
      ),
    );
  }

  void _handleItemTap(BuildContext context, NavigationItem item) {
    Navigator.pop(context);

    if (item.isExternal) {
      openExternalUrl(context, item.externalUrl!);
    } else if (item.isRoute) {
      onSectionTap?.call(item.id);
    }
  }
}
