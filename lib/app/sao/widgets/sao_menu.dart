import 'package:flutter/material.dart';

import '../sao_section.dart';
import '../sao_theme.dart';
import 'sao_widgets.dart';

/// Menu de botões circulares do modo SAO.
///
/// Parâmetros:
/// - [current]: janela aberta no momento (fica destacada em laranja).
/// - [onSelect]: chamado ao tocar em um botão.
/// - [vertical]: coluna à esquerda (desktop) ou linha na parte de baixo (mobile).
class SaoMenu extends StatelessWidget {
  const SaoMenu({
    super.key,
    required this.current,
    required this.onSelect,
    this.vertical = true,
  });

  final SaoSection? current;
  final ValueChanged<SaoSection> onSelect;
  final bool vertical;

  @override
  Widget build(BuildContext context) {
    final sections = SaoSection.values;
    final buttons = [
      for (var i = 0; i < sections.length; i++)
        _MenuButton(
          section: sections[i],
          shortcut: i + 1,
          active: current == sections[i],
          compact: !vertical,
          onTap: () => onSelect(sections[i]),
        ),
    ];
    return vertical
        ? Column(mainAxisSize: MainAxisSize.min, children: _spaced(buttons))
        : Row(mainAxisSize: MainAxisSize.min, children: _spaced(buttons));
  }

  List<Widget> _spaced(List<Widget> children) => [
    for (var i = 0; i < children.length; i++) ...[
      if (i > 0) SizedBox(width: vertical ? 12 : 6, height: 12),
      children[i],
    ],
  ];
}

class _MenuButton extends StatefulWidget {
  const _MenuButton({
    required this.section,
    required this.shortcut,
    required this.active,
    required this.compact,
    required this.onTap,
  });

  final SaoSection section;
  final int shortcut;
  final bool active;
  final bool compact;
  final VoidCallback onTap;

  @override
  State<_MenuButton> createState() => _MenuButtonState();
}

class _MenuButtonState extends State<_MenuButton> {
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    final size = widget.compact ? 40.0 : 56.0;
    final circle = BorderRadius.circular(size / 2);

    return Tooltip(
      message: '${widget.section.label}  (${widget.shortcut})',
      preferBelow: false,
      textStyle: SaoText.display.copyWith(color: SaoColors.ink, fontSize: 12),
      decoration: BoxDecoration(
        color: SaoColors.ink,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Semantics(
        button: true,
        selected: widget.active,
        label: widget.section.label,
        child: MouseRegion(
          cursor: SystemMouseCursors.click,
          onEnter: (_) => setState(() => _hover = true),
          onExit: (_) => setState(() => _hover = false),
          child: GestureDetector(
            onTap: widget.onTap,
            child: AnimatedScale(
              scale: _hover ? 1.07 : 1,
              duration: MediaQuery.disableAnimationsOf(context)
                  ? Duration.zero
                  : const Duration(milliseconds: 180),
              child: SizedBox(
                width: size,
                height: size,
                child: SaoGlass(
                  borderRadius: circle,
                  color: widget.active ? SaoColors.orange : SaoColors.panel,
                  child: Center(
                    child: Icon(
                      widget.section.icon,
                      size: widget.compact ? 21 : 24,
                      color: widget.active ? SaoColors.skyTop : SaoColors.ink2,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
