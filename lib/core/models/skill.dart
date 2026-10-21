import 'package:flutter/material.dart';

/// Dados de uma habilidade técnica exibida como chip no portfólio.
///
/// Parâmetros:
/// - `name`: nome da tecnologia ou habilidade.
/// - `color`: cor de fundo associada à marca.
/// - `onColor`: cor do texto sobre o fundo; por padrão, é branca.
/// - `url`: endereço de referência aberto ao tocar no chip.
class Skill {
  final String name;
  final Color color;
  final Color onColor;
  final String url;

  const Skill({
    required this.name,
    required this.color,
    this.onColor = Colors.white,
    required this.url,
  });
}
