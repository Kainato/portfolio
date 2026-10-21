/// Assets locais usados pela interface do aplicativo.
enum Assets { dashatar, caioPortrait }

/// Resolve cada asset para seu caminho dentro do projeto.
extension AssetsExtension on Assets {
  String get path {
    switch (this) {
      case Assets.dashatar:
        return 'assets/home/dashatar.png';
      case Assets.caioPortrait:
        return 'assets/home/caio_portrait.jpg';
    }
  }
}
