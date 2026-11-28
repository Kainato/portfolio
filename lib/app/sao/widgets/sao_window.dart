import 'package:flutter/material.dart';

import '../sao_section.dart';
import '../sao_theme.dart';
import 'sao_widgets.dart';

/// Janela flutuante que mostra o conteúdo da seção escolhida no menu.
///
/// Parâmetros:
/// - [section]: seção exibida no cabeçalho.
/// - [onClose]: fecha a janela (botão ✕ ou tecla Esc).
/// - [child]: conteúdo rolável da janela.
class SaoWindow extends StatelessWidget {
  const SaoWindow({
    super.key,
    required this.section,
    required this.onClose,
    required this.child,
  });

  final SaoSection section;
  final VoidCallback onClose;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final reduceMotion = MediaQuery.disableAnimationsOf(context);
    return SaoGlass(
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.fromLTRB(18, 14, 10, 14),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [SaoColors.panel, SaoColors.panel],
              ),
              border: Border(bottom: BorderSide(color: SaoColors.line)),
            ),
            child: Row(
              children: [
                Container(
                  width: 4,
                  height: 18,
                  decoration: BoxDecoration(
                    color: SaoColors.orange,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        section.label,
                        style: SaoText.display.copyWith(
                          fontSize: 17,
                          letterSpacing: 2.6,
                        ),
                      ),
                      Text(section.subtitle, style: SaoText.mono),
                    ],
                  ),
                ),
                IconButton(
                  tooltip: 'Fechar (Esc)',
                  onPressed: onClose,
                  icon: const Icon(
                    Icons.close_rounded,
                    color: SaoColors.ink2,
                    size: 20,
                  ),
                  hoverColor: SaoColors.red.withValues(alpha: 0.12),
                ),
              ],
            ),
          ),
          Expanded(
            child: AnimatedSwitcher(
              duration: reduceMotion
                  ? Duration.zero
                  : const Duration(milliseconds: 250),
              transitionBuilder: (child, animation) => FadeTransition(
                opacity: animation,
                child: SlideTransition(
                  position: Tween(
                    begin: const Offset(0, 0.02),
                    end: Offset.zero,
                  ).animate(animation),
                  child: child,
                ),
              ),
              child: SingleChildScrollView(
                key: ValueKey(section),
                padding: const EdgeInsets.all(18),
                child: child,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
