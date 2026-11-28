import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kainato_portfolio/core/data/portfolio_data.dart';

import 'panels/achievements_panel.dart';
import 'panels/floors_panel.dart';
import 'panels/party_panel.dart';
import 'panels/quests_panel.dart';
import 'panels/skills_panel.dart';
import 'panels/status_panel.dart';
import 'sao_data.dart';
import 'sao_section.dart';
import 'sao_theme.dart';
import 'widgets/sao_background.dart';
import 'widgets/sao_boot_overlay.dart';
import 'widgets/sao_hud.dart';
import 'widgets/sao_menu.dart';
import 'widgets/sao_toast.dart';
import 'widgets/sao_window.dart';

/// Portfólio em modo jogo inspirado em Sword Art Online.
///
/// Usa os mesmos dados de [PortfolioData] do modo clássico.
///
/// Atalhos: `1`–`6` abrem as janelas, `Esc` fecha e `M` volta ao modo clássico.
///
/// Parâmetros:
/// - [onExit]: volta ao modo clássico. Se nulo, faz `Navigator.maybePop`.
class SaoPage extends StatefulWidget {
  const SaoPage({super.key, this.onExit});

  final VoidCallback? onExit;

  @override
  State<SaoPage> createState() => _SaoPageState();
}

class _SaoPageState extends State<SaoPage> {
  final SaoToastController _toasts = SaoToastController();
  final FocusNode _focusNode = FocusNode(debugLabel: 'SaoPage');

  bool _booted = false;
  bool _showBoot = true;
  SaoSection? _current;

  // Mantém o conteúdo visível durante a animação de fechamento da janela
  SaoSection? _lastShown;

  @override
  void dispose() {
    _toasts.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _enter() {
    if (_booted) return;
    setState(() => _booted = true);
    _toasts.show('Login concluído', 'Bem-vindo, visitante');
    Future.delayed(const Duration(milliseconds: 900), () {
      if (mounted && _current == null) _open(SaoSection.status);
    });
  }

  void _exit() {
    final onExit = widget.onExit;
    if (onExit != null) {
      onExit();
    } else {
      Navigator.of(context).maybePop();
    }
  }

  void _open(SaoSection section) {
    setState(() {
      _current = _current == section ? null : section;
      _lastShown = section;
    });
  }

  void _close() => setState(() => _current = null);

  KeyEventResult _onKey(FocusNode node, KeyEvent event) {
    if (event is! KeyDownEvent) return KeyEventResult.ignored;

    if (!_booted) {
      if (event.logicalKey == LogicalKeyboardKey.enter) {
        _enter();
        return KeyEventResult.handled;
      }
      return KeyEventResult.ignored;
    }
    if (event.logicalKey == LogicalKeyboardKey.escape) {
      _close();
      return KeyEventResult.handled;
    }
    if (event.logicalKey == LogicalKeyboardKey.keyM) {
      _exit();
      return KeyEventResult.handled;
    }
    final digit = int.tryParse(event.character ?? '');
    if (digit != null && digit >= 1 && digit <= SaoSection.values.length) {
      _open(SaoSection.values[digit - 1]);
      return KeyEventResult.handled;
    }
    return KeyEventResult.ignored;
  }

  Widget _panelFor(SaoSection section) => switch (section) {
    SaoSection.status => const StatusPanel(),
    SaoSection.skills => SkillsPanel(toasts: _toasts),
    SaoSection.floors => const FloorsPanel(),
    SaoSection.quests => QuestsPanel(toasts: _toasts),
    SaoSection.achievements => const AchievementsPanel(),
    SaoSection.party => PartyPanel(toasts: _toasts),
  };

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final wide = size.width > 760;
    final current = _current;
    final shown = current ?? _lastShown;
    final reduceMotion = MediaQuery.disableAnimationsOf(context);
    final motion = reduceMotion
        ? Duration.zero
        : const Duration(milliseconds: 300);

    return Focus(
      focusNode: _focusNode,
      autofocus: true,
      onKeyEvent: _onKey,
      child: Scaffold(
        body: Stack(
          children: [
            const Positioned.fill(child: SaoBackground()),

            // Título do andar atual
            if (wide)
              Positioned(
                right: size.width * 0.06,
                bottom: 96,
                child: IgnorePointer(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        'ANDAR ${SaoData.level.toString().padLeft(2, '0')} · ZONA SEGURA',
                        style: SaoText.mono.copyWith(
                          fontSize: 12,
                          letterSpacing: 2.4,
                        ),
                      ),
                      Text(
                        'Aincrad Dev',
                        style: SaoText.display.copyWith(
                          fontSize: (size.width * 0.04).clamp(28.0, 52.0),
                          color: SaoColors.ink.withValues(alpha: 0.75),
                        ),
                      ),
                      SizedBox(
                        width: 420,
                        child: Text(
                          'Desenvolvedor Flutter Sênior · Mobile & Web. Abra o menu para explorar.',
                          textAlign: TextAlign.right,
                          style: SaoText.body.copyWith(fontSize: 14),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

            if (_booted) ...[
              Positioned(
                left: wide ? 24 : 12,
                top: wide ? 22 : 12,
                child: const SaoHud(),
              ),
              if (wide)
                Positioned(
                  left: 24,
                  top: 0,
                  bottom: 0,
                  child: Center(
                    child: SaoMenu(current: current, onSelect: _open),
                  ),
                )
              else
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 110,
                  child: Center(
                    child: SaoMenu(
                      current: current,
                      onSelect: _open,
                      vertical: false,
                    ),
                  ),
                ),
            ],

            // Janela da seção aberta
            Positioned(
              left: wide ? 104 : 12,
              right: wide ? null : 12,
              top: wide ? 110 : 120,
              bottom: wide ? 70 : 170,
              width: wide ? (size.width - 130).clamp(0.0, 640.0) : null,
              child: IgnorePointer(
                ignoring: current == null,
                child: AnimatedOpacity(
                  opacity: current == null ? 0 : 1,
                  duration: motion,
                  child: AnimatedSlide(
                    offset: current == null
                        ? const Offset(-0.03, 0)
                        : Offset.zero,
                    duration: motion,
                    curve: Curves.easeOutCubic,
                    child: shown == null
                        ? const SizedBox.shrink()
                        : SaoWindow(
                            section: shown,
                            onClose: _close,
                            child: _panelFor(shown),
                          ),
                  ),
                ),
              ),
            ),

            // Atalhos e botão de voltar ao modo clássico
            if (_booted && wide)
              Positioned(
                left: 24,
                bottom: 24,
                child: Text(
                  'Atalhos: 1–6 menus · Esc fechar · M modo clássico',
                  style: SaoText.mono,
                ),
              ),
            if (_booted)
              Positioned(
                right: 22,
                bottom: 22,
                child: TextButton.icon(
                  onPressed: _exit,
                  icon: const Icon(Icons.logout_rounded, size: 16),
                  label: Text(
                    'MODO CLÁSSICO',
                    style: SaoText.display.copyWith(
                      fontSize: 12.5,
                      color: Colors.white,
                    ),
                  ),
                  style: TextButton.styleFrom(
                    backgroundColor: SaoColors.ink,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                    shape: const StadiumBorder(),
                  ),
                ),
              ),

            Positioned(
              right: 22,
              top: 22,
              child: SaoToastHost(controller: _toasts),
            ),

            // Abertura "LINK START"
            if (_showBoot)
              Positioned.fill(
                child: IgnorePointer(
                  ignoring: _booted,
                  child: AnimatedOpacity(
                    opacity: _booted ? 0 : 1,
                    duration: reduceMotion
                        ? Duration.zero
                        : const Duration(milliseconds: 700),
                    onEnd: () => setState(() => _showBoot = false),
                    child: AnimatedScale(
                      scale: _booted ? 1.15 : 1,
                      duration: reduceMotion
                          ? Duration.zero
                          : const Duration(milliseconds: 700),
                      child: SaoBootOverlay(onEnter: _enter, onClassic: _exit),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
