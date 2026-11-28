# Portfólio · Caio Calado

Portfólio pessoal em Flutter Web, publicado no GitHub Pages: <https://kainato.github.io/portfolio/>.

## Estrutura

```text
lib/
├── app/
│   ├── home/                 # Página clássica: hero, skills, projetos e contato
│   ├── projects/             # Detalhes dos projetos
│   └── sao/                  # Modo jogo, painéis e dados exclusivos de jogo
├── core/
│   ├── audio/                # Áudio opcional da interface
│   ├── data/                 # PortfolioData, fonte única dos dados
│   ├── localization/         # Idioma e traduções
│   ├── models/               # Modelos de projetos, experiência e skills
│   ├── routes/               # GoRouter e rotas com path URL strategy
│   └── theme/                # Tokens e tema central
└── widgets/                  # Componentes reutilizáveis

assets/projects/              # Conteúdo Markdown dos detalhes
assets/sounds/                # Efeitos de interface e créditos CC0
web/                          # Shell HTML, SEO, imagem social e fallback 404
```

O conteúdo profissional é mantido em `lib/core/data/portfolio_data.dart`; o modo clássico e o modo SAO consomem os mesmos dados. Apenas níveis, atributos, ranks e marcos de jogo vivem em `lib/app/sao/sao_data.dart`.

## Dependências

- `font_awesome_flutter`: ícones.
- `url_launcher`: abertura de links externos.
- `go_router`: navegação por URLs e detalhes com deep links.
- `flutter_markdown_plus`: renderização dos arquivos Markdown de projeto no Flutter Web; continuação mantida da implementação original `flutter_markdown`.
- `audioplayers`: efeitos curtos opcionais no Flutter Web.
- `shared_preferences`: persistência local da preferência de mudo.
- `flutter_web_plugins`: biblioteca do SDK usada para remover o `#` das URLs.

## Projetos

Os projetos usam os slugs definidos no modelo `PortfolioProject`, com categoria `work` ou `lab`. Os detalhes ficam em `assets/projects/<slug>.md`; fatos ausentes estão marcados como `<!-- TODO: preencher com dados do LinkedIn -->` para evitar conteúdo inventado.

## Modo SAO

O modo clássico continua sendo a página inicial. **LINK START** abre `/sao`; no SAO, o menu é lateral no desktop e fica em linha no mobile. `Enter` inicia a abertura, `1` a `6` navegam entre as janelas, `Esc` fecha e `M` volta ao clássico. O fundo é estático e as animações respeitam `MediaQuery.disableAnimationsOf`.

O seletor de modo e o botão de mudo ficam fixos no canto inferior direito, com espaço reservado no conteúdo. Os efeitos de áudio só são reproduzidos após gestos e a falha de áudio não interrompe a navegação. Os arquivos de áudio são CC0 e têm os créditos em `assets/sounds/CREDITS.md`.

## GitHub Pages e URLs diretas

`usePathUrlStrategy()` gera URLs sem `#`. Ao publicar em GitHub Pages no subdiretório `/portfolio/`, compile com a base correta e publique o shell `404.html` junto do `index.html`. O `web/404.html` é mantido idêntico ao `web/index.html` para que URLs de projeto e recarregamentos diretos retornem o app Flutter.

```powershell
flutter pub get
flutter analyze
flutter build web --base-href /portfolio/
Copy-Item build/web/index.html build/web/404.html -Force
Copy-Item build/web/* docs/ -Recurse -Force
```

O GitHub Pages deste repositório publica a pasta versionada `docs/`; por isso, copie o conteúdo compilado para ela após a build. Não há workflow de deploy em `.github/workflows` neste checkout.

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
