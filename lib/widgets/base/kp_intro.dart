import 'package:flutter/material.dart';

import '../../core/extension/context_extension.dart';
import 'scroll_reveal.dart';

/// Bloco introdutório que apresenta o título e a descrição de uma seção.
///
/// Parâmetros:
/// - `title`: título curto exibido em destaque.
/// - `content`: texto descritivo exibido abaixo do título.
class KpIntro extends StatelessWidget {
  final String title;
  final String content;

  /// Este widget renderiza uma seção introdutória com um título curto e uma mensagem principal de destaque.
  /// Ele é adequado para páginas de apresentação, portfólios e landing pages,
  /// ajudando a comunicar a identidade profissional ou institucional de forma clara, visualmente impactante e responsiva.
  ///
  /// Ele é construído como um *[StatelessWidget]* e pode ser extendido com um *[SliverToBoxAdapter]* para integração com listas de rolagem.
  const KpIntro({super.key, required this.title, required this.content});

  SliverToBoxAdapter buildSliver(BuildContext context) {
    return SliverToBoxAdapter(child: ScrollReveal(child: build(context)));
  }

  @override
  Widget build(BuildContext context) {
    final horizontalPadding = context.isMobile ? 20.0 : 32.0;
    return Padding(
      padding: EdgeInsets.fromLTRB(
        horizontalPadding,
        90,
        horizontalPadding,
        35,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1100),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  color: context.primaryColor,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                content,
                style: TextStyle(
                  fontSize: context.isMobile ? 22 : 28,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
