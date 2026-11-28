import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';

/// Aliases legados do HUD apontam para os tokens centrais do app.
abstract final class SaoColors {
  static const background = AppColors.background;
  static const surface = AppColors.surface;
  static const skyTop = AppColors.background;
  static const skyMid = AppColors.background;
  static const skyBottom = AppColors.background;
  static const surfaceRaised = AppColors.surfaceRaised;
  static const ink = AppColors.textPrimary;
  static const ink2 = AppColors.textSecondary;
  static const ink3 = AppColors.textSecondary;
  static const panel = AppColors.surfaceGlass;
  static const line = AppColors.outlineGlass;
  static const orange = AppColors.highlight;
  static const orangeLight = AppColors.highlight;
  static const orangeSoft = AppColors.highlightTint;
  static const orangeText = AppColors.highlight;
  static const blue = AppColors.accent;
  static const blueSoft = AppColors.accentTint;
  static const cyan = AppColors.textPrimary;
  static const green = AppColors.accent;
  static const greenLight = AppColors.accent;
  static const greenText = AppColors.accent;
  static const red = AppColors.error;
}

abstract final class SaoText {
  static const display = TextStyle(
    color: AppColors.textPrimary,
    fontWeight: FontWeight.w600,
    letterSpacing: 1.2,
  );
  static const mono = TextStyle(
    fontFamily: 'monospace',
    color: AppColors.textSecondary,
    fontSize: 11,
    letterSpacing: 0.8,
  );
  static const body = TextStyle(
    color: AppColors.textSecondary,
    fontSize: 13.5,
    height: 1.5,
  );
}
