import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kainato_portfolio/core/data/portfolio_data.dart';
import 'package:kainato_portfolio/core/models/portfolio_project.dart';
import 'package:url_launcher/url_launcher.dart';

import '../sao_data.dart';
import '../sao_theme.dart';
import '../widgets/sao_toast.dart';
import '../widgets/sao_widgets.dart';

/// Janela MISSÕES: lista dos projetos e, ao tocar, o detalhe da missão com
/// objetivo (challenge), estratégia (solution) e recompensa (impact).
class QuestsPanel extends StatefulWidget {
  const QuestsPanel({super.key, required this.toasts});

  final SaoToastController toasts;

  @override
  State<QuestsPanel> createState() => _QuestsPanelState();
}

class _QuestsPanelState extends State<QuestsPanel> {
  PortfolioProject? _selected;

  void _open(PortfolioProject project) {
    setState(() => _selected = project);
    widget.toasts.show('Missão aberta', project.title);
  }

  @override
  Widget build(BuildContext context) {
    final selected = _selected;
    return AnimatedSwitcher(
      duration: MediaQuery.disableAnimationsOf(context)
          ? Duration.zero
          : const Duration(milliseconds: 250),
      child: selected == null
          ? _QuestList(key: const ValueKey('list'), onOpen: _open)
          : _QuestDetail(
              key: ValueKey(selected.order),
              project: selected,
              toasts: widget.toasts,
              onBack: () => setState(() => _selected = null),
            ),
    );
  }
}

class _QuestList extends StatelessWidget {
  const _QuestList({super.key, required this.onOpen});

  final ValueChanged<PortfolioProject> onOpen;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (final project in PortfolioData.projects)
          Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: SaoCard(
              padding: const EdgeInsets.all(12),
              onTap: () => onOpen(project),
              child: Row(
                children: [
                  SizedBox(
                    width: 44,
                    child: Text(
                      project.order,
                      textAlign: TextAlign.center,
                      style: SaoText.display.copyWith(
                        fontSize: 20,
                        color: SaoColors.orange,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          project.title,
                          style: SaoText.display.copyWith(
                            fontSize: 14.5,
                            letterSpacing: 0.4,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          project.stack,
                          style: SaoText.body.copyWith(
                            fontSize: 12.5,
                            color: SaoColors.ink3,
                          ),
                        ),
                      ],
                    ),
                  ),
                  _RankBadge(rank: SaoData.questRanks[project.order] ?? 'A'),
                ],
              ),
            ),
          ),
      ],
    );
  }
}

class _RankBadge extends StatelessWidget {
  const _RankBadge({required this.rank});

  final String rank;

  @override
  Widget build(BuildContext context) {
    final isLow = rank == 'B';
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: isLow ? SaoColors.blueSoft : SaoColors.orangeSoft,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        'RANK $rank',
        style: SaoText.mono.copyWith(
          color: isLow ? const Color(0xFF1C6EA8) : SaoColors.orangeText,
        ),
      ),
    );
  }
}

class _QuestDetail extends StatelessWidget {
  const _QuestDetail({
    super.key,
    required this.project,
    required this.toasts,
    required this.onBack,
  });

  final PortfolioProject project;
  final SaoToastController toasts;
  final VoidCallback onBack;

  @override
  Widget build(BuildContext context) {
    final String? url = project.url;
    final String? period = project.period;
    final List<String> tags = project.tags;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextButton.icon(
          onPressed: onBack,
          icon: const Icon(Icons.arrow_back_rounded, size: 16),
          label: Text(
            'voltar às missões',
            style: SaoText.mono.copyWith(fontSize: 12),
          ),
          style: TextButton.styleFrom(
            foregroundColor: SaoColors.ink2,
            padding: EdgeInsets.zero,
          ),
        ),
        const SizedBox(height: 8),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              project.order,
              style: SaoText.display.copyWith(
                fontSize: 38,
                color: SaoColors.orange,
                height: 1,
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    project.title,
                    style: SaoText.display.copyWith(
                      fontSize: 20,
                      letterSpacing: 0.4,
                    ),
                  ),
                  Text(
                    period == null || period.isEmpty
                        ? project.subtitle
                        : '${project.subtitle} · $period',
                    style: SaoText.body,
                  ),
                ],
              ),
            ),
          ],
        ),
        if (tags.isNotEmpty) ...[
          const SizedBox(height: 12),
          Wrap(
            spacing: 6,
            runSpacing: 6,
            children: [
              for (final tag in tags)
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 3,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: SaoColors.line),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    tag,
                    style: SaoText.mono.copyWith(color: SaoColors.ink),
                  ),
                ),
            ],
          ),
        ],
        const SizedBox(height: 12),
        _QuestBox(
          label: 'Objetivo · desafio',
          color: SaoColors.red,
          text: project.challenge,
        ),
        _QuestBox(
          label: 'Estratégia · solução',
          color: SaoColors.blue,
          text: project.solution,
        ),
        _QuestBox(
          label: 'Recompensa · impacto',
          color: SaoColors.greenText,
          text: project.impact,
        ),
        // Espaço reservado para print ou GIF do projeto
        Container(
          height: 130,
          margin: const EdgeInsets.only(top: 2),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: SaoColors.ink.withValues(alpha: 0.25)),
          ),
          child: Text(
            '[ espaço para print ou GIF do projeto ]',
            style: SaoText.mono,
          ),
        ),
        const SizedBox(height: 14),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            if (url != null && url.isNotEmpty)
              SaoButton(
                label: 'ABRIR MISSÃO ↗',
                onPressed: () => launchUrl(
                  Uri.parse(url),
                  mode: LaunchMode.externalApplication,
                ),
              ),
            SaoButton(
              label: 'COPIAR LINK',
              primary: false,
              onPressed: () {
                Clipboard.setData(
                  ClipboardData(
                    text:
                        'https://kainato.github.io/portfolio/projetos/${project.order}',
                  ),
                );
                toasts.show('Link copiado', 'URL própria por projeto');
              },
            ),
          ],
        ),
      ],
    );
  }
}

class _QuestBox extends StatelessWidget {
  const _QuestBox({
    required this.label,
    required this.color,
    required this.text,
  });

  final String label;
  final Color color;
  final String? text;

  @override
  Widget build(BuildContext context) {
    final value = text;
    final missing = value == null || value.isEmpty;
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: SizedBox(
        width: double.infinity,
        child: SaoCard(
          dashed: missing,
          padding: const EdgeInsets.fromLTRB(14, 12, 14, 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label.toUpperCase(),
                style: SaoText.mono.copyWith(
                  fontSize: 10.5,
                  color: color,
                  letterSpacing: 1.4,
                ),
              ),
              const SizedBox(height: 3),
              Text(
                missing ? 'Ainda não preenchido no portfólio.' : value,
                style: missing
                    ? SaoText.body.copyWith(
                        color: SaoColors.ink3,
                        fontStyle: FontStyle.italic,
                      )
                    : SaoText.body,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
