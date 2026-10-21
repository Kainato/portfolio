import 'package:flutter/material.dart';
import 'package:kainato_portfolio/core/extension/context_extension.dart';
import 'package:kainato_portfolio/core/theme/app_text_styles.dart';

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
          child: const _AboutProfile(),
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
              const TextSpan(text: 'Sou desenvolvedor Flutter Sênior, com '),
              TextSpan(text: 'mais de 6 anos de experiência', style: emphasis),
              const TextSpan(
                text:
                    ' criando aplicações mobile e web. Na TiTa Therapy, construí e mantive uma plataforma usada diariamente por ',
              ),
              TextSpan(text: 'mais de 10 redes de clínicas', style: emphasis),
              const TextSpan(
                text:
                    '. Na Amigo Tech / Clínica Mundos, colaborei com a Teatech para digitalizar processos e unificar ',
              ),
              TextSpan(text: '3 sistemas legados', style: emphasis),
              const TextSpan(
                text:
                    '. Também trabalho com arquitetura reativa, integração via APIs REST, publicação nas lojas e gestão ágil de projetos.',
              ),
            ],
          ),
        ),
        const SizedBox(height: 28),
        LayoutBuilder(
          builder: (context, constraints) {
            final columns = constraints.maxWidth >= 850
                ? 3
                : constraints.maxWidth >= 280
                ? 2
                : 1;
            return GridView.count(
              crossAxisCount: columns,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              mainAxisSpacing: 14,
              crossAxisSpacing: 14,
              childAspectRatio: columns == 3
                  ? 1.8
                  : columns == 2
                  ? (constraints.maxWidth < 380 ? 0.9 : 1.45)
                  : 2.1,
              children: const [
                _AboutAchievement(
                  value: '6+',
                  label: 'anos de atuação',
                  detail: 'Flutter mobile e web',
                  icon: Icons.workspace_premium_outlined,
                ),
                _AboutAchievement(
                  value: '10+',
                  label: 'redes atendidas',
                  detail: 'pela TiTa Therapy',
                  icon: Icons.domain_outlined,
                ),
                _AboutAchievement(
                  value: '3',
                  label: 'sistemas legados',
                  detail: 'unificados na Teatech',
                  icon: Icons.hub_outlined,
                ),
              ],
            );
          },
        ),
      ],
    );
  }
}

/// Cartão de destaque para uma conquista profissional mensurável.
///
/// Parâmetros:
/// - `value`: número ou resultado em destaque.
/// - `label`: resumo da conquista.
/// - `detail`: contexto curto do resultado.
/// - `icon`: ícone que identifica visualmente a conquista.
class _AboutAchievement extends StatelessWidget {
  const _AboutAchievement({
    required this.value,
    required this.label,
    required this.detail,
    required this.icon,
  });

  final String value;
  final String label;
  final String detail;
  final IconData icon;

  @override
  Widget build(BuildContext context) => Container(
    padding: EdgeInsets.all(context.isMobile ? 12 : 14),
    decoration: BoxDecoration(
      color: context.primaryColor.withValues(alpha: 0.08),
      borderRadius: BorderRadius.circular(20),
      border: Border.all(color: context.primaryColor.withValues(alpha: 0.2)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 30,
          height: 30,
          decoration: BoxDecoration(
            color: context.primaryColor,
            borderRadius: BorderRadius.circular(11),
          ),
          child: Icon(icon, color: context.onPrimaryColor, size: 17),
        ),
        const SizedBox(height: 7),
        FittedBox(
          fit: BoxFit.scaleDown,
          alignment: Alignment.centerLeft,
          child: Text(
            value,
            style: context.headlineMedium?.copyWith(
              color: context.primaryColor,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
        Text(
          label,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: context.titleSmall?.copyWith(fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 4),
        Text(
          detail,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: context.bodyMedium?.copyWith(
            color: context.onSurfaceVariantColor,
            height: 1.3,
          ),
        ),
      ],
    ),
  );
}
