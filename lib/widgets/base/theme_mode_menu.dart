import 'package:flutter/material.dart';

import '../../core/theme/theme_mode_controller.dart';

/// Toque curto alterna entre claro e escuro; toque longo abre as opções.
class ThemeModeMenu extends StatelessWidget {
  const ThemeModeMenu({super.key, this.showLabel = false});

  final bool showLabel;

  static String labelFor(ThemeMode mode) => switch (mode) {
    ThemeMode.light => 'Claro',
    ThemeMode.dark => 'Escuro',
    ThemeMode.system => 'Sistema',
  };

  static IconData iconFor(ThemeMode mode) => switch (mode) {
    ThemeMode.light => Icons.light_mode_outlined,
    ThemeMode.dark => Icons.dark_mode_outlined,
    ThemeMode.system => Icons.brightness_auto_outlined,
  };

  @override
  Widget build(BuildContext context) => AnimatedBuilder(
    animation: ThemeModeController.instance,
    builder: (context, _) {
      final mode = ThemeModeController.instance.mode;
      return Builder(
        builder: (buttonContext) => Semantics(
          button: true,
          label:
              'Tema atual: ${labelFor(mode)}. Toque para alternar; segure para ver opções.',
          child: Tooltip(
            message: 'Toque para alternar o tema; segure para ver opções',
            child: InkWell(
              borderRadius: BorderRadius.circular(12),
              mouseCursor: SystemMouseCursors.click,
              onTap: () => _toggleTheme(mode),
              onLongPress: () => _showOptions(buttonContext, mode),
              child: showLabel
                  ? ListTile(
                      leading: Icon(iconFor(mode)),
                      title: const Text('Tema'),
                      subtitle: Text(labelFor(mode)),
                      trailing: const Icon(Icons.expand_more),
                    )
                  : Padding(
                      padding: const EdgeInsets.all(8),
                      child: Icon(iconFor(mode)),
                    ),
            ),
          ),
        ),
      );
    },
  );

  void _toggleTheme(ThemeMode mode) {
    final systemBrightness =
        WidgetsBinding.instance.platformDispatcher.platformBrightness;
    final isCurrentlyDark = switch (mode) {
      ThemeMode.light => false,
      ThemeMode.dark => true,
      ThemeMode.system => systemBrightness == Brightness.dark,
    };
    ThemeModeController.instance.setMode(
      isCurrentlyDark ? ThemeMode.light : ThemeMode.dark,
    );
  }

  Future<void> _showOptions(BuildContext context, ThemeMode mode) async {
    final button = context.findRenderObject()! as RenderBox;
    final overlay = Overlay.of(context).context.findRenderObject()! as RenderBox;
    final buttonRect = Rect.fromPoints(
      button.localToGlobal(Offset.zero, ancestor: overlay),
      button.localToGlobal(
        button.size.bottomRight(Offset.zero),
        ancestor: overlay,
      ),
    );
    final selectedMode = await showMenu<ThemeMode>(
      context: context,
      position: RelativeRect.fromRect(buttonRect, Offset.zero & overlay.size),
      initialValue: mode,
      items: ThemeMode.values
          .map(
            (option) => PopupMenuItem<ThemeMode>(
              value: option,
              child: Row(
                children: [
                  Icon(iconFor(option)),
                  const SizedBox(width: 12),
                  Text(labelFor(option)),
                  const Spacer(),
                  if (option == mode)
                    Icon(
                      Icons.check,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                ],
              ),
            ),
          )
          .toList(),
    );
    if (selectedMode != null) {
      ThemeModeController.instance.setMode(selectedMode);
    }
  }
}
