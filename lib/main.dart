import 'package:flutter/material.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:kainato_portfolio/core/audio/sound_service.dart';
import 'package:kainato_portfolio/app.dart';
import 'dart:async';

/// ### O ponto de entrada da aplicação Flutter.
///
/// A função *[main]* é responsável por iniciar a execução do aplicativo, chamando a função *[runApp]* e passando uma instância do widget *[MainApp]* como argumento. Isso configura o ambiente necessário para renderizar a interface do usuário e iniciar o ciclo de vida do aplicativo.
void main() {
  usePathUrlStrategy();
  runApp(const MainApp());
  unawaited(
    SoundService.instance.loadPreference().then(
      (_) => SoundService.instance.preload(),
    ),
  );
}
