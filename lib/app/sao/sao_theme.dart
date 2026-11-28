import 'package:flutter/material.dart';

/// Paleta do modo SAO: céu claro, painéis translúcidos e destaques em laranja.
abstract final class SaoColors {
  static const Color skyTop = Color(0xFFCFE3F3);
  static const Color skyMid = Color(0xFFE9F3FB);
  static const Color skyBottom = Color(0xFFF7EFE4);

  static const Color ink = Color(0xFF2B3440);
  static const Color ink2 = Color(0xFF5D6B7A);
  static const Color ink3 = Color(0xFF8B98A6);

  static const Color panel = Color(0xDBFAFBFC);
  static const Color line = Color(0x1F2B3440);

  static const Color orange = Color(0xFFF39A1E);
  static const Color orangeLight = Color(0xFFFFB547);
  static const Color orangeSoft = Color(0xFFFFF1DC);
  static const Color orangeText = Color(0xFFA35E00);

  static const Color blue = Color(0xFF2A8FD8);
  static const Color blueSoft = Color(0xFFE3F1FB);
  static const Color cyan = Color(0xFF4FC6E8);
  static const Color green = Color(0xFF5AC46D);
  static const Color greenLight = Color(0xFF9BE07A);
  static const Color greenText = Color(0xFF2F9A45);
  static const Color red = Color(0xFFE2574C);
}

/// Estilos de texto do modo SAO.
///
/// As fontes "Bahnschrift" e "Consolas" são só sugestões: no Flutter Web elas
/// precisam ser declaradas como asset no pubspec (veja o README_SAO.md).
abstract final class SaoText {
  static const TextStyle display = TextStyle(
    fontFamily: 'Bahnschrift',
    fontFamilyFallback: ['Segoe UI', 'Roboto'],
    color: SaoColors.ink,
    fontWeight: FontWeight.w600,
    letterSpacing: 1.2,
  );

  static const TextStyle mono = TextStyle(
    fontFamily: 'Consolas',
    fontFamilyFallback: ['Courier New', 'monospace'],
    color: SaoColors.ink3,
    fontSize: 11,
    letterSpacing: 0.8,
  );

  static const TextStyle body = TextStyle(
    color: SaoColors.ink2,
    fontSize: 13.5,
    height: 1.5,
  );
}
