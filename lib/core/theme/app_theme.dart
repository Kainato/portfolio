import 'package:flutter/material.dart';

import 'app_colors.dart';

/// Tema central usado no modo clássico, nos detalhes e no modo SAO.
abstract final class AppTheme {
  static final ColorScheme colorScheme = const ColorScheme.dark(
    primary: AppColors.accent,
    onPrimary: AppColors.background,
    secondary: AppColors.highlight,
    onSecondary: AppColors.background,
    error: AppColors.error,
    onError: AppColors.background,
    surface: AppColors.surface,
    onSurface: AppColors.textPrimary,
    surfaceContainerLowest: AppColors.background,
    surfaceContainerLow: AppColors.surface,
    surfaceContainer: AppColors.surfaceRaised,
    surfaceContainerHigh: AppColors.surfaceRaised,
    surfaceContainerHighest: AppColors.surfaceRaised,
    outline: AppColors.textSecondary,
    outlineVariant: Color(0xFF3D444E),
  );

  static final ThemeData dark = _build();
  static final ThemeData light = dark;

  static ThemeData _build() => ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    colorScheme: colorScheme,
    scaffoldBackgroundColor: AppColors.background,
    textTheme: ThemeData.dark().textTheme.apply(
      bodyColor: AppColors.textPrimary,
      displayColor: AppColors.textPrimary,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.background,
      foregroundColor: AppColors.textPrimary,
      elevation: 0,
    ),
    cardTheme: CardThemeData(
      color: AppColors.surface,
      elevation: 0,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    ),
    dividerTheme: const DividerThemeData(color: AppColors.surfaceRaised),
    focusColor: AppColors.highlight,
    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(
        backgroundColor: AppColors.accent,
        foregroundColor: AppColors.background,
        enabledMouseCursor: SystemMouseCursors.click,
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: AppColors.accent,
        side: const BorderSide(color: AppColors.accent),
        enabledMouseCursor: SystemMouseCursors.click,
      ),
    ),
  );
}
