import 'package:flutter/material.dart';
import 'package:kainato_portfolio/core/routes/kp_routes.dart';
import 'package:kainato_portfolio/core/theme/app_theme.dart';
import 'package:kainato_portfolio/core/theme/theme_mode_controller.dart';

import 'app/home/home_page.dart';

/// O *[MainApp]* é um widget sem estado que representa a aplicação Flutter.
/// Ele define o título do aplicativo, as rotas disponíveis, a rota inicial e o tema do aplicativo.
/// A página inicial é definida como *[HomePage]*.
///
/// Parâmetros: este widget não recebe parâmetros além da chave padrão do Flutter.
///
/// Variáveis:
/// - **[title]:** O título do aplicativo.
/// - **[routes]:** Um mapa de rotas disponíveis na aplicação. Definido por uma variável construída a partir do enum *[KpRoutes]*.
/// - **[initialRoute]:** A rota inicial que será exibida ao iniciar o aplicativo. Definida pelo enum *[KpRoutes]*.
/// - **[theme]:** O tema centralizado do aplicativo (paleta, tipografia e componentes).
/// - **[home]:** A página inicial do aplicativo, definida como *[HomePage]*.
class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) => AnimatedBuilder(
    animation: ThemeModeController.instance,
    builder: (context, _) => MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Caio Calado — Flutter Developer',
      routes: allAppRoutes,
      initialRoute: KpRoutes.home.path,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: ThemeModeController.instance.mode,
      home: const HomePage(),
      // Deep links desconhecidos caem de volta na Home em vez de uma tela de erro.
      onUnknownRoute: (settings) =>
          MaterialPageRoute(builder: (_) => const HomePage()),
    ),
  );

}
