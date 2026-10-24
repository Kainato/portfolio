import 'package:flutter/material.dart';
import 'package:kainato_portfolio/widgets/layout/kp_app_bar.dart';

import '../../core/extension/context_extension.dart';
import '../../core/routes/kp_routes.dart';
import '../drawer/kp_drawer.dart';

/// Estrutura visual das páginas com app bar e drawer para telas pequenas.
///
/// Parâmetros:
/// - `body`: conteúdo principal exibido abaixo da barra.
/// - `route`: rota atual repassada aos componentes de navegação.
/// - `onSectionTap`: callback para navegar até uma seção da página.
class KpScaffold extends StatelessWidget {
  /// O corpo do scaffold.
  final Widget? body;

  /// A página (rota) atual do scaffold.
  final KpRoutes route;

  /// Callback acionado quando uma seção é tocada no app bar ou drawer.
  final void Function(String sectionId)? onSectionTap;

  /// `KpScaffold` é um widget de scaffold personalizado que inclui um
  /// app bar personalizado (`KpAppBar`) e um drawer condicional que só é exibido para telas menores.
  ///
  /// ### Parâmetros
  /// - `body`: O corpo do scaffold.
  /// - `route`: A página (rota) atual do scaffold.
  /// - `onSectionTap`: Callback acionado quando uma seção é tocada no app bar ou drawer.
  const KpScaffold({
    super.key,
    required this.body,
    this.route = KpRoutes.home,
    this.onSectionTap,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: KpAppBar(currentRoute: route, onSectionTap: onSectionTap),
      drawer: context.isMobile
          ? KpDrawer(route: route, onSectionTap: onSectionTap)
          : null,
      body: body ?? const Center(child: CircularProgressIndicator()),
    );
  }
}
