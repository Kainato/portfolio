import 'package:flutter/material.dart';
import 'package:kainato_portfolio/core/extension/context_extension.dart';

class ProcessSection extends StatelessWidget {
  final EdgeInsets sectionPadding;

  const ProcessSection({super.key, required this.sectionPadding});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: sectionPadding,
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1100),
          child: Wrap(
            spacing: 18,
            runSpacing: 28,
            children: [
              _ProcessStep(
                context: context,
                number: '01',
                title: 'Problema',
                text: 'O que precisava ser resolvido?',
              ),
              _ProcessStep(
                context: context,
                number: '02',
                title: 'Pesquisa',
                text: 'O que foi descoberto?',
              ),
              _ProcessStep(
                context: context,
                number: '03',
                title: 'Design',
                text: 'Quais decisões foram tomadas?',
              ),
              _ProcessStep(
                context: context,
                number: '04',
                title: 'Código',
                text: 'Como a solução foi implementada?',
              ),
              _ProcessStep(
                context: context,
                number: '05',
                title: 'Resultado',
                text: 'O que mudou depois?',
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ProcessStep extends StatelessWidget {
  final BuildContext context;
  final String number;
  final String title;
  final String text;

  const _ProcessStep({
    required this.context,
    required this.number,
    required this.title,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: context.isMobile ? context.width - 40 : 205,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            number,
            style: TextStyle(
              color: context.primaryColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            title,
            style: context.titleLarge?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 6),
          Text(
            text,
            style: context.bodyMedium?.copyWith(
              color: context.onSurfaceVariantColor,
              height: 1.35,
            ),
          ),
        ],
      ),
    );
  }
}
