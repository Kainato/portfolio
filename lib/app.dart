import 'package:flutter/material.dart';
import 'package:kainato_portfolio/core/localization/app_language.dart';
import 'package:kainato_portfolio/core/routes/app_router.dart';
import 'package:kainato_portfolio/core/theme/app_theme.dart';

/// O *[MainApp]* é um widget sem estado que representa a aplicação Flutter.
/// Define o roteador e o tema compartilhado do aplicativo.
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
    animation: AppLanguageController.instance,
    builder: (context, _) => MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Caio Calado — Desenvolvedor Flutter',
      routerConfig: appRouter,
      theme: AppTheme.dark,
      darkTheme: AppTheme.dark,
      themeMode: ThemeMode.dark,
    ),
  );
}
