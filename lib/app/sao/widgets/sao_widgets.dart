import 'package:flutter/material.dart';

import '../sao_theme.dart';

/// Painel de vidro translúcido usado no HUD, no menu e nas janelas.
class SaoGlass extends StatelessWidget {
  const SaoGlass({
    super.key,
    required this.child,
    this.borderRadius = const BorderRadius.all(Radius.circular(16)),
    this.padding = EdgeInsets.zero,
    this.color = SaoColors.panel,
  });

  final Widget child;
  final BorderRadius borderRadius;
  final EdgeInsetsGeometry padding;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: borderRadius,
      clipBehavior: Clip.hardEdge,
      child: Container(
        padding: padding,
        decoration: BoxDecoration(
          color: color,
          borderRadius: borderRadius,
          border: Border.all(color: SaoColors.line),
        ),
        child: child,
      ),
    );
  }
}

/// Cartão branco com borda fina, usado dentro das janelas.
class SaoCard extends StatelessWidget {
  const SaoCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(14),
    this.onTap,
    this.dashed = false,
  });

  final Widget child;
  final EdgeInsetsGeometry padding;
  final VoidCallback? onTap;

  // Cartões "pendentes" (sem fundo) para itens bloqueados ou não preenchidos
  final bool dashed;

  @override
  Widget build(BuildContext context) {
    final radius = BorderRadius.circular(12);
    return Material(
      color: dashed ? Colors.transparent : SaoColors.panel,
      shape: RoundedRectangleBorder(
        borderRadius: radius,
        side: BorderSide(
          color: dashed
              ? SaoColors.ink3.withValues(alpha: 0.45)
              : SaoColors.line,
        ),
      ),
      clipBehavior: Clip.hardEdge,
      child: InkWell(
        onTap: onTap,
        hoverColor: SaoColors.blueSoft,
        child: Padding(padding: padding, child: child),
      ),
    );
  }
}

/// Barra de progresso que se preenche com animação (HP, EXP, atributos).
class SaoBar extends StatelessWidget {
  const SaoBar({
    super.key,
    required this.value,
    required this.colors,
    this.height = 8,
  });

  final double value;
  final List<Color> colors;
  final double height;

  @override
  Widget build(BuildContext context) {
    final reduceMotion = MediaQuery.disableAnimationsOf(context);
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0, end: value.clamp(0.0, 1.0)),
      duration: reduceMotion
          ? Duration.zero
          : const Duration(milliseconds: 1200),
      curve: Curves.easeOutCubic,
      builder: (context, v, _) => Container(
        height: height,
        decoration: BoxDecoration(
          color: SaoColors.ink.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(height / 2),
        ),
        alignment: Alignment.centerLeft,
        child: FractionallySizedBox(
          widthFactor: v,
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: colors),
              borderRadius: BorderRadius.circular(height / 2),
            ),
          ),
        ),
      ),
    );
  }
}

/// Grade responsiva: usa [columns] colunas quando cabe e uma coluna em telas estreitas.
class SaoGrid extends StatelessWidget {
  const SaoGrid({
    super.key,
    required this.children,
    this.columns = 2,
    this.minItemWidth = 220,
    this.spacing = 10,
  });

  final List<Widget> children;
  final int columns;
  final double minItemWidth;
  final double spacing;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        var cols = columns;
        while (cols > 1 &&
            (constraints.maxWidth - spacing * (cols - 1)) / cols <
                minItemWidth) {
          cols--;
        }
        final itemWidth = (constraints.maxWidth - spacing * (cols - 1)) / cols;
        return Wrap(
          spacing: spacing,
          runSpacing: spacing,
          children: [
            for (final child in children)
              SizedBox(width: itemWidth, child: child),
          ],
        );
      },
    );
  }
}

/// Rótulo em caixa alta que separa blocos dentro de uma janela.
class SaoSectionLabel extends StatelessWidget {
  const SaoSectionLabel(this.text, {super.key});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16, bottom: 8),
      child: Text(
        text.toUpperCase(),
        style: SaoText.mono.copyWith(letterSpacing: 1.6),
      ),
    );
  }
}

/// Observação com borda laranja à esquerda (ex.: "valores de exemplo").
class SaoNote extends StatelessWidget {
  const SaoNote(this.text, {super.key});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 12),
      padding: const EdgeInsets.only(left: 8),
      decoration: const BoxDecoration(
        border: Border(left: BorderSide(color: SaoColors.orange, width: 2)),
      ),
      child: Text(text, style: SaoText.mono),
    );
  }
}

/// Botão em formato de pílula, nas variantes preenchida (laranja) e fantasma.
class SaoButton extends StatelessWidget {
  const SaoButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.primary = true,
  });

  final String label;
  final VoidCallback onPressed;
  final bool primary;

  @override
  Widget build(BuildContext context) {
    final style = SaoText.display.copyWith(
      fontSize: 13,
      letterSpacing: 1.5,
      color: primary ? SaoColors.skyTop : SaoColors.ink,
    );
    return Semantics(
      button: true,
      label: label,
      child: Material(
        color: primary ? SaoColors.orange : SaoColors.panel,
        shape: StadiumBorder(
          side: primary
              ? BorderSide.none
              : const BorderSide(color: SaoColors.line),
        ),
        elevation: primary ? 4 : 0,
        shadowColor: SaoColors.orange.withValues(alpha: 0.5),
        child: InkWell(
          customBorder: const StadiumBorder(),
          onTap: onPressed,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            child: Text(label, style: style),
          ),
        ),
      ),
    );
  }
}
