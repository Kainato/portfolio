import 'package:flutter/material.dart';
import 'package:kainato_portfolio/core/data/portfolio_data.dart';
import 'package:kainato_portfolio/core/enum/assets.dart';
import 'package:kainato_portfolio/core/extension/context_extension.dart';
import 'package:kainato_portfolio/core/utils/kp_launcher.dart';
import 'package:kainato_portfolio/widgets/base/kp_fallback_image.dart';

/// Apresenta a introdução, a foto em telas grandes, o avatar mobile e atalhos.
///
/// Parâmetros:
/// - `onProjectsTap`: ação opcional para navegar até os projetos.
class HeroSection extends StatelessWidget {
  final VoidCallback? onProjectsTap;

  const HeroSection({super.key, this.onProjectsTap});

  @override
  Widget build(BuildContext context) {
    // A coluna lateral precisa caber junto ao texto e à foto; 1100 px deixava
    // telas de notebook sem a composição desktop, mesmo com espaço suficiente.
    final isDesktop = context.width >= 960;
    final imageSize = context.isMobile ? 180.0 : 280.0;
    final imagePath = isDesktop
        ? Assets.caioPortrait.path
        : Assets.dashatar.path;

    final textColumn = Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          PortfolioData.tagline,
          style: TextStyle(
            letterSpacing: 2,
            color: context.primaryColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 22),
        Text(
          'Olá, eu sou\n${PortfolioData.name}!',
          style: context.displayLarge?.copyWith(
            fontWeight: FontWeight.w800,
            height: 1,
            fontSize: context.isMobile ? 40 : null,
          ),
        ),
        const SizedBox(height: 25),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 720),
          child: Text(
            PortfolioData.heroDescription,
            style: context.bodyLarge?.copyWith(fontSize: 22, height: 1.5),
          ),
        ),
        const SizedBox(height: 35),
        Wrap(
          spacing: 14,
          runSpacing: 14,
          children: [
            Semantics(
              button: true,
              label: 'Ir para a seção de projetos',
              child: FilledButton(
                onPressed: onProjectsTap,
                child: const Text('Ver projetos'),
              ),
            ),
            Semantics(
              button: true,
              label: 'Abrir perfil no GitHub em uma nova aba',
              child: OutlinedButton(
                onPressed: () =>
                    openExternalUrl(context, 'https://github.com/Kainato'),
                child: const Text('GitHub'),
              ),
            ),
          ],
        ),
      ],
    );

    final image = Semantics(
      label: isDesktop
          ? 'Foto de Caio Calado de Araújo'
          : 'Avatar do Flutter Bird',
      image: true,
      child: Container(
        width: imageSize,
        height: imageSize,
        padding: EdgeInsets.all(isDesktop ? 5 : 0),
        decoration: BoxDecoration(
          border: isDesktop
              ? Border.all(color: context.primaryColor, width: 2)
              : null,
          borderRadius: BorderRadius.circular(isDesktop ? 22 : 0),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(isDesktop ? 16 : 0),
          child: KpFallbackImage(
            assetPath: imagePath,
            width: imageSize - (isDesktop ? 14 : 0),
            height: imageSize - (isDesktop ? 14 : 0),
            fit: isDesktop ? BoxFit.cover : BoxFit.contain,
          ),
        ),
      ),
    );

    return Container(
      constraints: const BoxConstraints(minHeight: 650),
      padding: EdgeInsets.all(context.isMobile ? 20 : 32),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1100),
          child: isDesktop
              ? Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(child: textColumn),
                    const SizedBox(width: 40),
                    image,
                  ],
                )
              : textColumn,
        ),
      ),
    );
  }
}
