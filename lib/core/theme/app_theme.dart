import 'package:flutter/material.dart';

/// Paletas base do aplicativo. Os esquemas de cores são derivados pelo
/// Material 3 a partir destas cores-semente.
///
/// Parâmetros: esta classe utilitária não recebe parâmetros.
abstract final class AppTheme {
  static const Color blueSea = Color(0xFF00C0FE);
  static const Color darkNight = Color(0xFF0E162C);

  static final ThemeData light = _buildTheme(
    brightness: Brightness.light,
    seedColor: blueSea,
  );

  static final ThemeData dark = _buildTheme(
    brightness: Brightness.dark,
    seedColor: darkNight,
  );

  static ThemeData _buildTheme({
    required Brightness brightness,
    required Color seedColor,
  }) {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: seedColor,
      brightness: brightness,
    );
    final isDark = brightness == Brightness.dark;
    final baseTextTheme = (isDark ? ThemeData.dark() : ThemeData.light())
        .textTheme
        .apply(
          bodyColor: colorScheme.onSurface,
          displayColor: colorScheme.onSurface,
        );

    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: colorScheme.surface,
      textTheme: baseTextTheme,
      appBarTheme: AppBarTheme(
        backgroundColor: colorScheme.surface,
        foregroundColor: colorScheme.onSurface,
        elevation: 0,
        centerTitle: false,
      ),
      iconButtonTheme: const IconButtonThemeData(
        style: ButtonStyle(
          mouseCursor: WidgetStatePropertyAll(SystemMouseCursors.click),
        ),
      ),
      cardTheme: CardThemeData(
        color: colorScheme.surfaceContainer,
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
      drawerTheme: DrawerThemeData(
        backgroundColor: colorScheme.surfaceContainerLow,
      ),
      dividerTheme: DividerThemeData(color: colorScheme.outlineVariant),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: colorScheme.primary,
          foregroundColor: colorScheme.onPrimary,
          enabledMouseCursor: SystemMouseCursors.click,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: colorScheme.primary,
          enabledMouseCursor: SystemMouseCursors.click,
          side: BorderSide(color: colorScheme.outline),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: colorScheme.primary,
          enabledMouseCursor: SystemMouseCursors.click,
        ),
      ),
    );
  }
}
