import 'package:flutter/material.dart';

import '../../core/extension/context_extension.dart';
import '../../core/localization/app_language.dart';
import '../../core/routes/kp_routes.dart';
import '../../core/routes/navigation_config.dart';
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
                tooltip: tr('Abrir menu de navegação'),
                icon: const Icon(Icons.menu),
                onPressed: Scaffold.of(context).openDrawer,
              ),
            )
          : null,
      title: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 34,
            height: 34,
            margin: const EdgeInsets.only(right: 10),
            decoration: BoxDecoration(
              color: const Color(0xFF102147),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const CustomPaint(painter: _LogoMarkPainter()),
          ),
          const Text('Caio Calado'),
        ],
      ),
      actions: [
        if (!isMobile) ...[
          for (final item in NavigationConfig.mainItems)
            KpAppbarAction(
              label: tr(item.label),
              onSectionTap: () => _handleSectionTap(context, item),
            ),
          const SizedBox(width: 8),
        ],
        const ThemeModeMenu(),
        PopupMenuButton<AppLanguage>(
          tooltip: tr('Selecionar idioma'),
          icon: const Icon(Icons.language),
          initialValue: AppLanguageController.instance.language,
          onSelected: AppLanguageController.instance.setLanguage,
          itemBuilder: (context) => [
            const PopupMenuItem(
              value: AppLanguage.ptBr,
              child: Text('Português (Brasil)'),
            ),
            const PopupMenuItem(
              value: AppLanguage.enUs,
              child: Text('Inglês (EUA)'),
            ),
          ],
        ),
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

class _LogoMarkPainter extends CustomPainter {
  const _LogoMarkPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final cPaint = Paint()
      ..color = const Color(0xFF70E8FF)
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width * 0.12
      ..strokeCap = StrokeCap.round;

    final terminalPaint = Paint()
      ..color = const Color(0xFFEAFBFF)
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width * 0.075
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    final cRect = Rect.fromLTWH(
      size.width * 0.14,
      size.height * 0.12,
      size.width * 0.72,
      size.height * 0.76,
    );
    canvas.drawArc(cRect, 0.72, 4.7, false, cPaint);

    canvas.drawPath(
      Path()
        ..moveTo(size.width * 0.43, size.height * 0.40)
        ..lineTo(size.width * 0.58, size.height * 0.50)
        ..lineTo(size.width * 0.43, size.height * 0.60),
      terminalPaint,
    );
    canvas.drawLine(
      Offset(size.width * 0.61, size.height * 0.70),
      Offset(size.width * 0.77, size.height * 0.70),
      terminalPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
