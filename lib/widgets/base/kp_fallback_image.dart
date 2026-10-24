import 'package:flutter/material.dart';

/// Exibe uma imagem local, um indicador durante o carregamento e um ícone se falhar.
///
/// Parâmetros:
/// - `assetPath`: caminho do asset que será carregado.
/// - `width`: largura da imagem e do fallback.
/// - `height`: altura da imagem e do fallback.
/// - `fit`: regra de ajuste da imagem no espaço disponível.
/// - `fallbackIcon`: ícone exibido quando a imagem não puder ser carregada.
class KpFallbackImage extends StatelessWidget {
  final String assetPath;
  final double? width;
  final double? height;
  final BoxFit fit;
  final IconData fallbackIcon;

  const KpFallbackImage({
    super.key,
    required this.assetPath,
    this.width,
    this.height,
    this.fit = BoxFit.contain,
    this.fallbackIcon = Icons.broken_image_outlined,
  });

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      assetPath,
      width: width,
      height: height,
      fit: fit,
      frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
        if (wasSynchronouslyLoaded || frame != null) return child;
        return SizedBox(
          width: width,
          height: height,
          child: const Center(child: CircularProgressIndicator()),
        );
      },
      errorBuilder: (context, error, stackTrace) => SizedBox(
        width: width,
        height: height,
        child: Center(
          child: Icon(
            fallbackIcon,
            size: 48,
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
        ),
      ),
    );
  }
}
