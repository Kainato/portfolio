import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/foundation.dart';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';

enum SoundEffect {
  linkStart,
  openPanel,
  closePanel,
  menu,
  select,
  toast,
  classicClick,
  emailCopied,
}

/// Serviço único e tolerante a falhas para áudio da interface.
class SoundService {
  SoundService._();
  static final SoundService instance = SoundService._();

  static const _muteKey = 'portfolio_sound_muted';
  final AudioPlayer _player = AudioPlayer();
  final ValueNotifier<bool> muted = ValueNotifier<bool>(false);
  bool _loaded = false;
  bool _preferenceLoaded = false;

  Future<void> preload() async {
    try {
      await _player.audioCache.loadAll([
        'sounds/link_start.wav',
        'sounds/open_panel.wav',
        'sounds/close_panel.wav',
        'sounds/menu.wav',
        'sounds/select.wav',
        'sounds/toast.wav',
        'sounds/classic_click.wav',
        'sounds/email_copied.wav',
      ]);
    } catch (_) {
      // O cache é opcional; AssetSource tenta carregar o arquivo quando preciso.
    }
  }

  Future<void> loadPreference() async {
    try {
      final value = await SharedPreferencesAsync().getBool(_muteKey) ?? false;
      if (!_preferenceLoaded) muted.value = value;
    } catch (_) {
      if (!_preferenceLoaded) muted.value = false;
    } finally {
      _preferenceLoaded = true;
    }
  }

  Future<void> setMuted(bool value) async {
    _preferenceLoaded = true;
    muted.value = value;
    try {
      await SharedPreferencesAsync().setBool(_muteKey, value);
    } catch (_) {
      // A preferência de áudio não deve afetar a navegação.
    }
  }

  void play(SoundEffect effect) {
    if (!_preferenceLoaded || muted.value) return;
    final asset = switch (effect) {
      SoundEffect.linkStart => 'sounds/link_start.wav',
      SoundEffect.openPanel => 'sounds/open_panel.wav',
      SoundEffect.closePanel => 'sounds/close_panel.wav',
      SoundEffect.menu => 'sounds/menu.wav',
      SoundEffect.select => 'sounds/select.wav',
      SoundEffect.toast => 'sounds/toast.wav',
      SoundEffect.classicClick => 'sounds/classic_click.wav',
      SoundEffect.emailCopied => 'sounds/email_copied.wav',
    };
    try {
      if (!_loaded) {
        _loaded = true;
        // Dispara a reprodução no gesto original para respeitar o autoplay web.
      }
      unawaited(
        _player
            .setVolume(effect == SoundEffect.classicClick ? 0.16 : 0.3)
            .catchError((_) {}),
      );
      unawaited(_player.play(AssetSource(asset)).catchError((_) {}));
    } catch (_) {
      // A interface continua operando sem áudio quando o asset falha.
    }
  }
}
