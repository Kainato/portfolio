import 'package:flutter/material.dart';
import 'package:kainato_portfolio/core/extension/context_extension.dart';
import 'package:kainato_portfolio/core/theme/app_text_styles.dart';

import '../../../core/localization/app_language.dart';

/// Apresenta o resumo profissional e indicadores de impacto.
///
/// Parâmetros:
/// - `sectionPadding`: espaçamento horizontal aplicado à seção.
class AboutSection extends StatelessWidget {
  final EdgeInsets sectionPadding;

  const AboutSection({super.key, required this.sectionPadding});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: sectionPadding,
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1100),
          child: AnimatedBuilder(
            animation: AppLanguageController.instance,
            builder: (context, _) => _AboutProfile(),
          ),
        ),
      ),
    );
  }
}

/// Apresenta a trajetória profissional com destaques e conquistas do currículo.
class _AboutProfile extends StatelessWidget {
  const _AboutProfile();

  @override
  Widget build(BuildContext context) {
    final emphasis = TextStyle(
      color: context.primaryColor,
      fontWeight: FontWeight.w700,
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text.rich(
          TextSpan(
            style: AppTextStyles.body(context),
            children: [
              TextSpan(text: tr('Sou desenvolvedor Flutter Sênior, com ')),
              TextSpan(
                text: tr('mais de 6 anos de experiência'),
                style: emphasis,
              ),
              TextSpan(
                text: tr(
                  ' criando aplicações mobile e web. Na TiTa Therapy, construí e mantive uma plataforma usada diariamente por ',
                ),
              ),
              TextSpan(
                text: tr('mais de 10 redes de clínicas'),
                style: emphasis,
              ),
              TextSpan(
                text: tr(
                  '. Na Amigo Tech / Clínica Mundos, colaborei com a Teatech para digitalizar processos e unificar ',
                ),
              ),
              TextSpan(text: tr('3 sistemas legados'), style: emphasis),
              TextSpan(
                text: tr(
                  '. Também trabalho com arquitetura reativa, integração via APIs REST, publicação nas lojas e gestão ágil de projetos.',
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
