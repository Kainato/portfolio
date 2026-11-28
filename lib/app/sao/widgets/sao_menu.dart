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
class SaoMenu extends StatefulWidget {
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
  State<SaoMenu> createState() => _SaoMenuState();
}

class _SaoMenuState extends State<SaoMenu> with SingleTickerProviderStateMixin {
  late final AnimationController _entry = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 700),
  )..forward();

  @override
  void dispose() {
    _entry.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final reduceMotion = MediaQuery.disableAnimationsOf(context);
    if (reduceMotion && _entry.value != 1) _entry.value = 1;
    final sections = SaoSection.values;
    final buttons = [
      for (var i = 0; i < sections.length; i++)
        _menuButton(i, sections, reduceMotion),
    ];
    return widget.vertical
        ? Column(mainAxisSize: MainAxisSize.min, children: _spaced(buttons))
        : Row(mainAxisSize: MainAxisSize.min, children: _spaced(buttons));
  }

  Widget _menuButton(int index, List<SaoSection> sections, bool reduceMotion) {
    final button = _MenuButton(
      section: sections[index],
      shortcut: index + 1,
      active: widget.current == sections[index],
      compact: !widget.vertical,
      onTap: () => widget.onSelect(sections[index]),
    );
    return reduceMotion
        ? button
        : _staggered(index: index, total: sections.length, child: button);
  }

  List<Widget> _spaced(List<Widget> children) => [
    for (var i = 0; i < children.length; i++) ...[
      if (i > 0) SizedBox(width: widget.vertical ? 12 : 6, height: 12),
      children[i],
    ],
  ];

  // Cada botão entra deslizando um pouco depois do anterior
  Widget _staggered({
    required int index,
    required int total,
    required Widget child,
  }) {
    final start = index / (total + 2);
    final animation = CurvedAnimation(
      parent: _entry,
      curve: Interval(
        start,
        (start + 0.4).clamp(0.0, 1.0),
        curve: Curves.easeOutCubic,
      ),
    );
    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) => Opacity(
        opacity: animation.value,
        child: Transform.translate(
          offset: widget.vertical
              ? Offset(-20 * (1 - animation.value), 0)
              : Offset(0, 20 * (1 - animation.value)),
          child: child,
        ),
      ),
      child: child,
    );
  }
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
      textStyle: SaoText.display.copyWith(color: Colors.white, fontSize: 12),
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
                  shadowBlur: 18,
                  color: widget.active ? SaoColors.orange : SaoColors.panel,
                  child: Center(
                    child: Icon(
                      widget.section.icon,
                      size: widget.compact ? 21 : 24,
                      color: widget.active ? Colors.white : SaoColors.ink2,
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
