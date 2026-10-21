import 'package:flutter/material.dart';

/// Estilos de texto compartilhados, baseados na escala tipográfica Material 3.
///
/// Parâmetros: esta classe utilitária não recebe parâmetros.
abstract final class AppTextStyles {
  /// Título principal usado para identificar cada seção.
  static TextStyle sectionTitle(BuildContext context) =>
      Theme.of(context).textTheme.headlineSmall!.copyWith(
        fontWeight: FontWeight.w700,
        height: 1.2,
      );

  /// Subtítulo usado para introduzir ou resumir uma seção.
  static TextStyle subtitle(BuildContext context) =>
      Theme.of(context).textTheme.titleLarge!.copyWith(
        fontWeight: FontWeight.w600,
        height: 1.2,
      );

  /// Texto de leitura longa com altura de linha confortável.
  static TextStyle body(BuildContext context) =>
      Theme.of(context).textTheme.bodyLarge!.copyWith(height: 1.5);
}
