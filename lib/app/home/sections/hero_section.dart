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
    final isMobile = context.isMobile;
    // A coluna lateral precisa caber junto ao texto e à foto em notebooks.
    final isDesktop = context.width >= 960;
    final image = _Portrait(isDesktop: isDesktop);

    final textColumn = Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (!isMobile) ...[
          Text(
            PortfolioData.name.toUpperCase(),
            style: context.labelLarge?.copyWith(
              letterSpacing: 2,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 7),
        ],
        if (!isMobile) ...[
          Text(
            PortfolioData.tagline,
            style: TextStyle(
              letterSpacing: 1.8,
              color: context.primaryColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 18),
        ],
        Text(
          'Transformo processos complexos em produtos digitais simples de usar.',
          style: context.displayLarge?.copyWith(
            fontWeight: FontWeight.w800,
            height: isMobile ? 1.08 : 1.03,
            fontSize: isMobile ? 34 : 54,
          ),
        ),
        const SizedBox(height: 20),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 620),
          child: Text(
            PortfolioData.heroDescription,
            style: context.bodyLarge?.copyWith(
              fontSize: isMobile ? 18 : 20,
              height: 1.5,
            ),
          ),
        ),
        const SizedBox(height: 28),
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
            Semantics(
              button: true,
              label: 'Abrir perfil no LinkedIn em uma nova aba',
              child: OutlinedButton(
                onPressed: () => openExternalUrl(
                  context,
                  'https://www.linkedin.com/in/kainato/',
                ),
                child: const Text('LinkedIn'),
              ),
            ),
          ],
        ),
        const SizedBox(height: 34),
        const _ImpactHighlights(),
      ],
    );

    return Container(
      constraints: BoxConstraints(minHeight: isMobile ? 0 : 650),
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 20 : 32,
        vertical: isMobile ? 28 : 32,
      ),
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
              : isMobile
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        image,
                        const SizedBox(width: 18),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                PortfolioData.name,
                                style: context.headlineSmall?.copyWith(
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                PortfolioData.tagline,
                                style: context.labelMedium?.copyWith(
                                  color: context.primaryColor,
                                  letterSpacing: 1.2,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 32),
                    textColumn,
                  ],
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(child: image),
                    const SizedBox(height: 32),
                    textColumn,
                  ],
                ),
        ),
      ),
    );
  }
}

class _Portrait extends StatelessWidget {
  const _Portrait({required this.isDesktop});

  final bool isDesktop;

  @override
  Widget build(BuildContext context) {
    final width = isDesktop ? 300.0 : 96.0;
    final height = isDesktop ? 380.0 : 120.0;

    return Semantics(
      label: 'Foto de Caio Calado de Araújo',
      image: true,
      child: Container(
        width: width,
        height: height,
        padding: EdgeInsets.all(isDesktop ? 5 : 0),
        decoration: BoxDecoration(
          border: Border.all(color: context.primaryColor, width: 2),
          borderRadius: BorderRadius.circular(isDesktop ? 22 : 16),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(isDesktop ? 16 : 12),
          child: KpFallbackImage(
            assetPath: Assets.caioPortrait.path,
            width: width - (isDesktop ? 14 : 0),
            height: height - (isDesktop ? 14 : 0),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}

class _ImpactHighlights extends StatelessWidget {
  const _ImpactHighlights();

  @override
  Widget build(BuildContext context) => LayoutBuilder(
    builder: (context, constraints) {
      const spacing = 16.0;
      final columns = constraints.maxWidth < 350
          ? 1
          : constraints.maxWidth < 500
          ? 2
          : 3;
      final itemWidth =
          (constraints.maxWidth - spacing * (columns - 1)) / columns;

      return Wrap(
        spacing: spacing,
        runSpacing: 16,
        children: [
          SizedBox(
            width: itemWidth,
            child: const _ImpactHighlight(
              value: '6+',
              label: 'anos com Flutter',
            ),
          ),
          SizedBox(
            width: itemWidth,
            child: const _ImpactHighlight(
              value: '10+',
              label: 'redes atendidas',
            ),
          ),
          SizedBox(
            width: itemWidth,
            child: const _ImpactHighlight(
              value: '3',
              label: 'sistemas unificados',
            ),
          ),
        ],
      );
    },
  );
}

class _ImpactHighlight extends StatelessWidget {
  const _ImpactHighlight({required this.value, required this.label});

  final String value;
  final String label;

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        value,
        style: context.headlineSmall?.copyWith(
          color: context.primaryColor,
          fontWeight: FontWeight.w800,
        ),
      ),
      const SizedBox(height: 2),
      Text(
        label,
        style: context.bodySmall?.copyWith(
          color: context.onSurfaceVariantColor,
        ),
      ),
    ],
  );
}
