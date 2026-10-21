import 'package:flutter/material.dart';
import 'package:kainato_portfolio/core/data/portfolio_data.dart';
import 'package:kainato_portfolio/core/enum/assets.dart';
import 'package:kainato_portfolio/core/extension/context_extension.dart';
import 'package:kainato_portfolio/core/utils/kp_launcher.dart';
import 'package:kainato_portfolio/widgets/base/kp_fallback_image.dart';

/// Apresenta a introdução principal, o avatar e atalhos para projetos e GitHub.
///
/// Parâmetros:
/// - `onProjectsTap`: ação opcional para navegar até os projetos.
class HeroSection extends StatelessWidget {
  final VoidCallback? onProjectsTap;

  const HeroSection({super.key, this.onProjectsTap});

  @override
  Widget build(BuildContext context) {
    final isDesktop = context.isDesktop;

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
      label: 'Ilustração de avatar do desenvolvedor',
      child: KpFallbackImage(
        assetPath: Assets.dashatar.path,
        width: 280,
        height: 280,
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
