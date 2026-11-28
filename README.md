# Portfólio · Caio Calado

Aplicação de portfólio pessoal feita com Flutter Web e publicada no GitHub Pages: <https://kainato.github.io/portfolio/>.

## O que o site apresenta

- Apresentação, trajetória profissional, habilidades, projetos e contato.
- Layout responsivo, tema claro/escuro e conteúdo em português ou inglês.
- Modo SAO opcional, com navegação em formato de jogo.

## Estrutura atual

```text
lib/
├── app/
│   ├── home/                 # Página clássica e suas seções
│   ├── sao/                  # Modo jogo e seus painéis/widgets
│   └── skills/               # Telas relacionadas a habilidades
├── core/
│   ├── data/                 # PortfolioData, fonte central do conteúdo
│   ├── enum/ extension/      # Tipos e extensões compartilhadas
│   ├── localization/         # Idioma e traduções
│   ├── models/               # Modelos de projetos, skills, etc.
│   ├── routes/               # Rotas nomeadas
│   ├── theme/                # Temas claro/escuro
│   └── utils/                # Utilitários, como abertura de links
└── widgets/                  # Componentes compartilhados
```

O conteúdo do portfólio é mantido em `lib/core/data/portfolio_data.dart` e tipado pelos modelos em `lib/core/models/`. A interface clássica e o modo SAO consomem essa mesma fonte. Os dados exclusivos de jogo, como níveis, atributos e ranks, ficam em `lib/app/sao/sao_data.dart`.

## Dependências

- Flutter e Dart.
- `flutter_web_plugins` (biblioteca incluída no SDK Flutter).
- [`font_awesome_flutter`](https://pub.dev/packages/font_awesome_flutter) para ícones.
- [`url_launcher`](https://pub.dev/packages/url_launcher) para links externos.

O projeto não usa MobX, Provider ou outra biblioteca de gerenciamento de estado. O estado local das telas usa os recursos do Flutter.

## Modo SAO

O modo clássico continua sendo a página inicial. O botão **LINK START** no hero abre `/sao`. No modo jogo, o menu lateral aparece em telas largas e vira uma linha na parte inferior em telas estreitas. As seis janelas exibem status, habilidades, trajetória, projetos, conquistas e contatos.

Atalhos: `Enter` inicia, `1` a `6` abrem as janelas, `Esc` fecha a janela e `M` retorna ao modo clássico. O modo respeita a preferência do sistema por animações reduzidas e usa apenas elementos visuais originais inspirados em interfaces de fantasia.

Os níveis e ranks são valores ilustrativos em `sao_data.dart`; atualize-os conforme desejar. Certificados ainda são dados provisórios e aparecem bloqueados no modo SAO até serem substituídos por dados reais.

## Desenvolvimento

```sh
flutter pub get
flutter analyze
flutter build web --base-href /portfolio/
```

## Contato

- GitHub: [@Kainato](https://github.com/Kainato)
- LinkedIn: [Caio Calado](https://www.linkedin.com/in/kainato/)
- E-mail: [caiocaladaraujo@gmail.com](mailto:caiocaladaraujo@gmail.com)
