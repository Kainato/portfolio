import 'package:flutter/material.dart';

import '../../app/home/home_page.dart';
import '../../app/sao/sao_page.dart';

/// Rotas nomeadas disponíveis no aplicativo.
enum KpRoutes { home, sao }

/// Fornece nome, caminho, ícone e construtor para uma rota do aplicativo.
extension KpRoutesExtension on KpRoutes {
  String get name {
    switch (this) {
      case KpRoutes.home:
        return 'Home';
      case KpRoutes.sao:
        return 'Modo SAO';
    }
  }

  String get path {
    switch (this) {
      case KpRoutes.home:
        return '/';
      case KpRoutes.sao:
        return '/sao';
    }
  }

  IconData get icon {
    switch (this) {
      case KpRoutes.home:
        return Icons.home_outlined;
      case KpRoutes.sao:
        return Icons.gamepad_outlined;
    }
  }

  WidgetBuilder get builder {
    switch (this) {
      case KpRoutes.home:
        return (context) => HomePage();
      case KpRoutes.sao:
        return (context) => const SaoPage();
    }
  }
}

/// Rotas nomeadas do app (exceto home, definida via `home` no [MaterialApp]).
Map<String, WidgetBuilder> get allAppRoutes => {
  for (final route in KpRoutes.values.where((r) => r != KpRoutes.home))
    route.path: route.builder,
};
