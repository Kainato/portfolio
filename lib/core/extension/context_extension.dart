import 'package:flutter/material.dart';

/// Atalhos de tamanho, tipografia e cores do tema para widgets Flutter.
extension ContextExtension on BuildContext {
  // !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
  // ! MediaQuery
  // !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
  double get width => MediaQuery.of(this).size.width;
  double get height => MediaQuery.of(this).size.height;

  // ***************************************************************************
  // * Breakpoints responsivos
  // ***************************************************************************
  bool get isMobile => width < 700;
  bool get isTablet => width >= 700 && width < 1100;
  bool get isDesktop => width >= 1100;

  // ***************************************************************************
  // * Text Theme
  // ***************************************************************************
  // * Title
  TextStyle? get titleLarge => Theme.of(this).textTheme.titleLarge;
  TextStyle? get titleMedium => Theme.of(this).textTheme.titleMedium;
  TextStyle? get titleSmall => Theme.of(this).textTheme.titleSmall;
  // * Body
  TextStyle? get bodyLarge => Theme.of(this).textTheme.bodyLarge;
  TextStyle? get bodyMedium => Theme.of(this).textTheme.bodyMedium;
  TextStyle? get bodySmall => Theme.of(this).textTheme.bodySmall;
  // * Display
  TextStyle? get displayLarge => Theme.of(this).textTheme.displayLarge;
  TextStyle? get displayMedium => Theme.of(this).textTheme.displayMedium;
  TextStyle? get displaySmall => Theme.of(this).textTheme.displaySmall;
  // * Headline
  TextStyle? get headlineLarge => Theme.of(this).textTheme.headlineLarge;
  TextStyle? get headlineMedium => Theme.of(this).textTheme.headlineMedium;
  TextStyle? get headlineSmall => Theme.of(this).textTheme.headlineSmall;
  // * Label
  TextStyle? get labelLarge => Theme.of(this).textTheme.labelLarge;
  TextStyle? get labelMedium => Theme.of(this).textTheme.labelMedium;
  TextStyle? get labelSmall => Theme.of(this).textTheme.labelSmall;

  // $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
  // $ Colors
  // $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
  // $ Primary
  Color get primaryColor => Theme.of(this).colorScheme.primary;
  Color get onPrimaryColor => Theme.of(this).colorScheme.onPrimary;
  // $ Secondary
  Color get secondaryColor => Theme.of(this).colorScheme.secondary;
  Color get onSecondaryColor => Theme.of(this).colorScheme.onSecondary;
  // $ Tertiary
  Color get tertiaryColor => Theme.of(this).colorScheme.tertiary;
  Color get onTertiaryColor => Theme.of(this).colorScheme.onTertiary;
  // $ Surface
  Color get surfaceColor => Theme.of(this).colorScheme.surface;
  Color get onSurfaceColor => Theme.of(this).colorScheme.onSurface;
  Color get onSurfaceVariantColor =>
      Theme.of(this).colorScheme.onSurfaceVariant;
  Color get surfaceBright => Theme.of(this).colorScheme.surfaceBright;
  Color get surfaceDim => Theme.of(this).colorScheme.surfaceDim;
  Color get surfaceTint => Theme.of(this).colorScheme.surfaceTint;
  Color get inverseSurface => Theme.of(this).colorScheme.inverseSurface;
  Color get onInverseSurface => Theme.of(this).colorScheme.onInverseSurface;
  // $ Surface Container
  Color get surfaceContainer => Theme.of(this).colorScheme.surfaceContainer;
  // $ Surface Container High
  Color get surfaceContainerHigh =>
      Theme.of(this).colorScheme.surfaceContainerHigh;
  Color get surfaceContainerHighest =>
      Theme.of(this).colorScheme.surfaceContainerHighest;
  // $ Surface Container Low
  Color get surfaceContainerLow =>
      Theme.of(this).colorScheme.surfaceContainerLow;
  Color get surfaceContainerLowest =>
      Theme.of(this).colorScheme.surfaceContainerLowest;
  // $ Error
  Color get errorColor => Theme.of(this).colorScheme.error;
  Color get onErrorColor => Theme.of(this).colorScheme.onError;
}
