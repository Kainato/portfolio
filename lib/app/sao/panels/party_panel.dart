import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kainato_portfolio/core/data/contact_link.dart';
import 'package:kainato_portfolio/core/data/portfolio_data.dart';
import 'package:url_launcher/url_launcher.dart';

import '../sao_theme.dart';
import '../widgets/sao_toast.dart';
import '../widgets/sao_widgets.dart';

/// Janela PARTY: canais de contato e o "convite de party", que copia o e-mail.
class PartyPanel extends StatelessWidget {
  const PartyPanel({super.key, required this.toasts});

  final SaoToastController toasts;

  @override
  Widget build(BuildContext context) {
    final email = PortfolioData.contacts
        .firstWhere((link) => link.type == ContactLinkType.email)
        .value;
    return Column(
      children: [
        for (final contact in PortfolioData.contacts)
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: SaoCard(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
              onTap: () => launchUrl(
                Uri.parse(contact.url),
                mode: LaunchMode.externalApplication,
              ),
              child: Row(
                children: [
                  Container(
                    width: 38,
                    height: 38,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: _contactColor(contact.type),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(contact.icon, color: Colors.white, size: 19),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          contact.label,
                          style: SaoText.display.copyWith(
                            fontSize: 14,
                            letterSpacing: 0.6,
                          ),
                        ),
                        Text(
                          contact.value,
                          style: SaoText.body.copyWith(
                            fontSize: 12.5,
                            color: SaoColors.ink3,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    'ABRIR ↗',
                    style: SaoText.mono.copyWith(color: SaoColors.ink2),
                  ),
                ],
              ),
            ),
          ),
        const SizedBox(height: 4),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Colors.white, SaoColors.orangeSoft],
            ),
            border: Border.all(color: const Color(0xFFFFD9A3)),
            borderRadius: BorderRadius.circular(14),
          ),
          child: Column(
            children: [
              Text(
                'ENVIAR CONVITE DE PARTY',
                style: SaoText.display.copyWith(
                  fontSize: 15,
                  letterSpacing: 1.6,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Copia o e-mail para você me chamar para um projeto.',
                textAlign: TextAlign.center,
                style: SaoText.body.copyWith(fontSize: 13),
              ),
              const SizedBox(height: 12),
              SaoButton(
                label: 'COPIAR E-MAIL',
                onPressed: () {
                  Clipboard.setData(ClipboardData(text: email));
                  toasts.show('Convite enviado', 'E-mail copiado');
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}

Color _contactColor(ContactLinkType type) => switch (type) {
  ContactLinkType.email => SaoColors.orange,
  ContactLinkType.linkedin => const Color(0xFF0A66C2),
  ContactLinkType.github => const Color(0xFF24292F),
  ContactLinkType.phone => SaoColors.green,
  ContactLinkType.website => SaoColors.blue,
};
