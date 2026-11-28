import 'package:flutter/material.dart';
import 'package:kainato_portfolio/core/data/portfolio_data.dart';
import 'package:url_launcher/url_launcher.dart';

import '../sao_data.dart';
import '../sao_theme.dart';
import '../widgets/sao_widgets.dart';

/// Janela CONQUISTAS: marcos reais e certificados.
///
/// Um certificado fica "bloqueado" enquanto o link de verificação for um
/// endereço de exemplo. A UI clássica não exibe esses links provisórios.
class AchievementsPanel extends StatelessWidget {
  const AchievementsPanel({super.key});

  @override
  Widget build(BuildContext context) {
    final hasPlaceholder = PortfolioData.certificates.any(
      (certificate) => _isPlaceholder(certificate.verificationUrl),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SaoSectionLabel('Marcos desbloqueados'),
        SaoGrid(
          children: [
            for (final milestone in SaoData.milestones)
              _Achievement(
                medal: Text(
                  milestone.emoji,
                  style: const TextStyle(fontSize: 18),
                ),
                title: milestone.title,
                description: milestone.description,
              ),
          ],
        ),
        const SaoSectionLabel('Certificados'),
        SaoGrid(
          children: [
            for (final certificate in PortfolioData.certificates)
              _isPlaceholder(certificate.verificationUrl)
                  ? _Achievement(
                      locked: true,
                      medal: const Icon(
                        Icons.lock_outline_rounded,
                        size: 18,
                        color: SaoColors.ink3,
                      ),
                      title: certificate.title,
                      description:
                          '${certificate.date} · aguardando certificado real',
                    )
                  : _Achievement(
                      medal: const Icon(
                        Icons.workspace_premium_rounded,
                        size: 20,
                        color: SaoColors.skyTop,
                      ),
                      title: certificate.title,
                      description:
                          '${certificate.issuer} · ${certificate.date}',
                      onTap: () =>
                          launchUrl(Uri.parse(certificate.verificationUrl)),
                    ),
          ],
        ),
        if (hasPlaceholder)
          const SaoNote(
            'Certificados provisórios aparecem bloqueados até receberem links reais.',
          ),
      ],
    );
  }

  static bool _isPlaceholder(String url) =>
      url.isEmpty || url.contains('example.com');
}

class _Achievement extends StatelessWidget {
  const _Achievement({
    required this.medal,
    required this.title,
    required this.description,
    this.locked = false,
    this.onTap,
  });

  final Widget medal;
  final String title;
  final String description;
  final bool locked;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return SaoCard(
      dashed: locked,
      padding: const EdgeInsets.all(12),
      onTap: onTap,
      child: Row(
        children: [
          Container(
            width: 42,
            height: 42,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: locked ? SaoColors.ink.withValues(alpha: 0.1) : null,
              gradient: locked
                  ? null
                  : const RadialGradient(
                      center: Alignment(-0.3, -0.4),
                      colors: [SaoColors.orange, SaoColors.orange],
                    ),
            ),
            child: medal,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: SaoText.display.copyWith(
                    fontSize: 13.5,
                    letterSpacing: 0.4,
                  ),
                ),
                Text(
                  description,
                  style: SaoText.body.copyWith(
                    fontSize: 12,
                    color: SaoColors.ink3,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
