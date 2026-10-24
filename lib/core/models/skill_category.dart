import 'package:flutter/material.dart';

import 'skill.dart';

/// Agrupa habilidades profissionais sob um título e uma descrição.
///
/// Parâmetros:
/// - `name`: nome da categoria.
/// - `description`: resumo do conteúdo da categoria.
/// - `skills`: habilidades incluídas na categoria.
/// - `icon`: ícone que representa a categoria.
class SkillCategory {
  final String name;
  final String description;
  final List<Skill> skills;
  final IconData icon;

  const SkillCategory({
    required this.name,
    required this.description,
    required this.skills,
    required this.icon,
  });
}
