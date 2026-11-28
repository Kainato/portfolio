import 'package:flutter/material.dart';

/// Janelas disponíveis no menu do modo SAO, na ordem dos atalhos 1 a 6.
enum SaoSection {
  status('STATUS', 'Janela do jogador', Icons.person_outline_rounded),
  skills('SKILLS', 'Árvore de habilidades', Icons.account_tree_outlined),
  floors('ANDARES', 'Trajetória profissional', Icons.apartment_rounded),
  quests('MISSÕES', 'Projetos concluídos', Icons.assignment_outlined),
  achievements(
    'CONQUISTAS',
    'Marcos e certificados',
    Icons.military_tech_outlined,
  ),
  party('PARTY', 'Contato', Icons.groups_outlined);

  const SaoSection(this.label, this.subtitle, this.icon);

  final String label;
  final String subtitle;
  final IconData icon;
}
