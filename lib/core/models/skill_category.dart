import 'package:flutter/material.dart';

import 'skill.dart';

/// Representa uma categoria de habilidades profissionais.
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
