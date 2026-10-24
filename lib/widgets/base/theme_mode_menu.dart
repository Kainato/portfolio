import 'package:flutter/material.dart';

import '../../core/theme/theme_mode_controller.dart';

/// Abre um menu explícito para selecionar a preferência de tema.
///
/// Parâmetros:
/// - `showLabel`: exibe o nome e o modo atual, indicado para o menu lateral.
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
      return Semantics(
        button: true,
        label: 'Tema atual: ${labelFor(mode)}',
        hint: 'Abrir opções de tema',
        child: PopupMenuButton<ThemeMode>(
          tooltip: 'Selecionar tema',
          initialValue: mode,
          onSelected: ThemeModeController.instance.setMode,
          icon: showLabel ? null : Icon(iconFor(mode)),
          child: showLabel
              ? ListTile(
                  leading: Icon(iconFor(mode)),
                  title: const Text('Tema'),
                  subtitle: Text(labelFor(mode)),
                  trailing: const Icon(Icons.expand_more),
                )
              : null,
          itemBuilder: (context) => ThemeMode.values
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
        ),
      );
    },
  );
}
