import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:kainato_portfolio/core/data/portfolio_data.dart';
import 'package:kainato_portfolio/core/audio/sound_service.dart';
import 'package:kainato_portfolio/widgets/layout/mode_sound_controls.dart';

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
    SoundService.instance.play(SoundEffect.linkStart);
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
      context.go('/');
    }
  }

  void _open(SaoSection section) {
    final closing = _current == section;
    SoundService.instance.play(
      closing ? SoundEffect.closePanel : SoundEffect.openPanel,
    );
    setState(() {
      _current = _current == section ? null : section;
      _lastShown = section;
    });
  }

  void _close() {
    SoundService.instance.play(SoundEffect.closePanel);
    setState(() => _current = null);
  }

  KeyEventResult _onKey(FocusNode node, KeyEvent event) {
    if (event is! KeyDownEvent) return KeyEventResult.ignored;

    if (!_booted) {
      if (event.logicalKey == LogicalKeyboardKey.enter) {
        _enter();
        return KeyEventResult.handled;
      }
      if (event.logicalKey == LogicalKeyboardKey.keyM) {
        _exit();
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
    SaoSection.quests => const QuestsPanel(),
    SaoSection.achievements => const AchievementsPanel(),
    SaoSection.party => PartyPanel(toasts: _toasts),
  };

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final wide = size.width > 760;
    final showProfessionalSummary = size.width >= 1280;
    final hudTop = wide ? 22.0 : 12.0;
    final hudLeft = wide ? 24.0 : 12.0;
    final hudHeight = wide ? 104.0 : 92.0;
    final windowTop = wide ? (hudTop + hudHeight + 14) : 260.0;
    final windowLeft = wide ? 104.0 : 12.0;
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
        body: SafeArea(
          child: Stack(
            children: [
              const Positioned.fill(child: SaoBackground()),

              // Destaques profissionais ficam no topo direito, fora da área do seletor.
              if (showProfessionalSummary)
                Positioned(
                  right: size.width * 0.06,
                  top: 390,
                  width: (size.width * 0.36).clamp(330.0, 520.0),
                  height: 180,
                  child: const SaoRightPanel(),
                ),
              if (_booted && !wide)
                Positioned(
                  left: 14,
                  right: 14,
                  top: 164,
                  child: IgnorePointer(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'LV ${SaoData.level} · ${SaoData.yearsOfExperience.floor()}+ ANOS DE CARREIRA',
                          style: SaoText.mono.copyWith(color: SaoColors.orange),
                        ),
                        Text(
                          PortfolioData.role,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: SaoText.display.copyWith(fontSize: 16),
                        ),
                        Text(
                          SaoData.milestones
                              .take(3)
                              .map((item) => item.title)
                              .join(' · '),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: SaoText.body.copyWith(fontSize: 11),
                        ),
                      ],
                    ),
                  ),
                ),
              if (showProfessionalSummary)
                Positioned(
                  right: size.width * 0.06,
                  top: 180,
                  width: (size.width * 0.36).clamp(330.0, 520.0),
                  child: IgnorePointer(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          'LV ${SaoData.level} · ${SaoData.yearsOfExperience.floor()}+ ANOS DE CARREIRA',
                          style: SaoText.mono.copyWith(
                            fontSize: 12,
                            letterSpacing: 2.4,
                          ),
                        ),
                        Text(
                          PortfolioData.role,
                          style: SaoText.display.copyWith(
                            fontSize: (size.width * 0.04).clamp(28.0, 52.0),
                            color: SaoColors.ink.withValues(alpha: 0.75),
                          ),
                        ),
                        SizedBox(
                          width: 420,
                          child: Text(
                            SaoData.milestones
                                .take(3)
                                .map(
                                  (item) =>
                                      '${item.title}: ${item.description}',
                                )
                                .join(' · '),
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
                  left: hudLeft,
                  top: hudTop,
                  child: SaoHud(compact: !wide),
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
                left: windowLeft,
                right: wide ? null : 12,
                top: windowTop,
                bottom: wide ? 100 : 182,
                width: wide
                    ? (size.width - 130).clamp(
                        0.0,
                        showProfessionalSummary ? 620.0 : 640.0,
                      )
                    : null,
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

              // Atalhos de teclado
              if (_booted && wide)
                Positioned(
                  left: 24,
                  bottom: 24,
                  child: Text(
                    'Atalhos: 1–6 menus · Esc fechar · M modo clássico',
                    style: SaoText.mono,
                  ),
                ),
              Positioned(
                right: 22,
                left: wide ? null : 12,
                top: wide ? 22 : 108,
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
                        child: SaoBootOverlay(
                          onEnter: _enter,
                          onClassic: _exit,
                        ),
                      ),
                    ),
                  ),
                ),

              const Positioned(
                right: 16,
                bottom: 16,
                child: ModeSoundControls(isSao: true),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SaoRightPanel extends StatelessWidget {
  const SaoRightPanel({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO(caio): conteúdo do painel direito em discussão
    return const SizedBox.expand();
  }
}
