import 'package:flutter/material.dart';

/// Mantém a preferência de tema compartilhada pelos controles do aplicativo.
///
/// Parâmetros: o controlador compartilhado não recebe parâmetros.
class ThemeModeController extends ChangeNotifier {
  ThemeModeController._();

  static final ThemeModeController instance = ThemeModeController._();

  ThemeMode _mode = ThemeMode.system;

  ThemeMode get mode => _mode;

  void setMode(ThemeMode mode) {
    if (_mode == mode) return;
    _mode = mode;
    notifyListeners();
  }
}
