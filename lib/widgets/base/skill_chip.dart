import 'package:flutter/material.dart';

import '../../core/models/skill.dart';
import '../../core/utils/kp_launcher.dart';

/// Chip interativo que apresenta uma habilidade e abre sua referência externa.
///
/// Parâmetros:
/// - `skill`: dados da habilidade, incluindo nome, cores e URL.
class SkillChip extends StatefulWidget {
  final Skill skill;
  const SkillChip({super.key, required this.skill});

  @override
  State<SkillChip> createState() => _SkillChipState();
}

/// Mantém o estado de hover usado para destacar o chip.
class _SkillChipState extends State<SkillChip> {
  bool _hovering = false;

  @override
  Widget build(BuildContext context) {
    final skill = widget.skill;
    return Semantics(
      button: true,
      label: 'Abrir referência sobre ${skill.name}',
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        onEnter: (_) => setState(() => _hovering = true),
        onExit: (_) => setState(() => _hovering = false),
        child: GestureDetector(
          onTap: () => openExternalUrl(context, skill.url),
          child: AnimatedScale(
            scale: _hovering ? 1.06 : 1,
            duration: const Duration(milliseconds: 150),
            curve: Curves.easeOut,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 150),
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              decoration: BoxDecoration(
                color: _hovering
                    ? skill.color
                    : skill.color.withValues(alpha: 0.85),
                borderRadius: BorderRadius.circular(20),
                boxShadow: _hovering
                    ? [
                        BoxShadow(
                          color: skill.color.withValues(alpha: 0.45),
                          blurRadius: 12,
                          offset: const Offset(0, 4),
                        ),
                      ]
                    : const [],
              ),
              child: Text(
                skill.name,
                style: TextStyle(
                  color: skill.onColor,
                  fontWeight: FontWeight.w600,
                  fontSize: 13,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
