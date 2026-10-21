import 'package:flutter/material.dart';
import 'package:kainato_portfolio/core/data/contact_link.dart';
import 'package:kainato_portfolio/core/extension/context_extension.dart';
import 'package:kainato_portfolio/core/theme/app_text_styles.dart';
import 'package:kainato_portfolio/core/utils/kp_launcher.dart';
import 'package:kainato_portfolio/widgets/base/section_tile.dart';

/// Exibe os canais de contato do portfólio.
///
/// Parâmetros: esta seção não recebe parâmetros.
class ContactSection extends StatelessWidget {
  const ContactSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: context.isMobile ? 40 : 90),
      padding: EdgeInsets.symmetric(
        horizontal: context.isMobile ? 20 : 32,
        vertical: 70,
      ),
      color: context.surfaceContainerLow,
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1100),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'VAMOS CONVERSAR?',
                style: AppTextStyles.sectionTitle(context).copyWith(
                  color: context.primaryColor,
                  letterSpacing: 2,
                ),
              ),
              const SizedBox(height: 14),
              Text(
                'Tem um projeto interessante?',
                style: AppTextStyles.subtitle(context),
              ),
              const SizedBox(height: 30),
              Wrap(
                spacing: 16,
                runSpacing: 16,
                children: [
                  for (final link in ContactLink.contactLinks)
                    _ContactChip(link: link),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Item clicável que apresenta um canal de contato e abre seu endereço.
///
/// Parâmetros:
/// - `link`: dados do canal, incluindo rótulo, endereço e ícone.
class _ContactChip extends StatelessWidget {
  final ContactLink link;
  const _ContactChip({required this.link});

  @override
  Widget build(BuildContext context) {
    return SectionTile(
      semanticLabel: 'Abrir ${link.label}: ${link.value}',
      onTap: () => openExternalUrl(context, link.url),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
        decoration: BoxDecoration(
          color: context.surfaceContainerHigh,
          borderRadius: BorderRadius.circular(14),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(link.icon, color: context.primaryColor, size: 20),
            const SizedBox(width: 10),
            Text(link.value, style: context.bodyMedium),
          ],
        ),
      ),
    );
  }
}
