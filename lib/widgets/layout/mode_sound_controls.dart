import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../core/audio/sound_service.dart';
import '../../core/theme/app_colors.dart';

class ModeSoundControls extends StatefulWidget {
  const ModeSoundControls({super.key, this.isSao});
  final bool? isSao;

  @override
  State<ModeSoundControls> createState() => _ModeSoundControlsState();
}

class _ModeSoundControlsState extends State<ModeSoundControls> {
  @override
  Widget build(BuildContext context) {
    final activeSao =
        widget.isSao ?? GoRouterState.of(context).uri.path == '/sao';
    return Material(
      color: AppColors.surface,
      borderRadius: BorderRadius.circular(28),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(28),
          border: Border.all(color: AppColors.surfaceRaised),
        ),
        padding: const EdgeInsets.all(4),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            ValueListenableBuilder<bool>(
              valueListenable: SoundService.instance.muted,
              builder: (context, muted, _) => Semantics(
                button: true,
                label: muted ? 'Ativar sons' : 'Silenciar sons',
                child: IconButton(
                  tooltip: muted ? 'Ativar sons' : 'Silenciar sons',
                  visualDensity: VisualDensity.compact,
                  onPressed: () => SoundService.instance.setMuted(!muted),
                  icon: Icon(
                    muted
                        ? Icons.volume_off_outlined
                        : Icons.volume_up_outlined,
                  ),
                ),
              ),
            ),
            _modeButton(context, 'CLÁSSICO', !activeSao, () {
              SoundService.instance.play(SoundEffect.menu);
              context.go('/');
            }),
            _modeButton(context, 'MODO SAO', activeSao, () {
              SoundService.instance.play(SoundEffect.menu);
              context.go('/sao');
            }),
          ],
        ),
      ),
    );
  }

  Widget _modeButton(
    BuildContext context,
    String label,
    bool active,
    VoidCallback onPressed,
  ) => Semantics(
    button: true,
    selected: active,
    label: 'Abrir $label',
    child: TextButton(
      onPressed: active ? null : onPressed,
      style: TextButton.styleFrom(
        foregroundColor: active
            ? AppColors.background
            : AppColors.textSecondary,
        backgroundColor: active ? AppColors.highlight : Colors.transparent,
        minimumSize: const Size(0, 40),
        padding: const EdgeInsets.symmetric(horizontal: 11),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
      child: Text(
        label,
        style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
      ),
    ),
  );
}
