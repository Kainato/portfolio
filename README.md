# 📱 Flutter Portfolio | Caio Calado

> Aplicativo de portfólio mobile desenvolvido em Flutter, projetado para apresentar experiências profissionais, projetos de destaque e competências técnicas com alta performance e fluidez.

## 📱 Demonstração

| Tela Inicial | Projetos | Detalhes / Contato |
| :---: | :---: | :---: |
| ![Home](https://via.placeholder.com/200x400.png?text=Home) | ![Projects](https://via.placeholder.com/200x400.png?text=Projetos) | ![Contact](https://via.placeholder.com/200x400.png?text=Contato) |

## 🎯 Sobre o Projeto

Este repositório hospeda o código-fonte do portfólio pessoal em formato de aplicativo móvel. O objetivo é demonstrar na prática o domínio do framework Flutter, padrões arquiteturais modernos e boas práticas de desenvolvimento, servindo como uma vitrine interativa.

## ✨ Principais Funcionalidades

* 📂 **Vitrine de Projetos:** Listagem detalhada de aplicações desenvolvidas com links diretos para repositórios e demonstrações.
* 👨‍💻 **Timeline Profissional:** Histórico de carreira detalhando experiências em desenvolvimento mobile e liderança técnica.
* 🎨 **Tema Dinâmico:** Suporte nativo a modo claro e escuro adaptado às preferências do sistema.
* 🔗 **Integração com Contatos:** Atalhos rápidos para redes profissionais e canais de comunicação.

## 🏛️ Arquitetura

O projeto segue os princípios de **Clean Architecture** e separação de responsabilidades, estruturado na pasta `lib/`:

```text
lib/
├── core/          # Configurações globais, rotas, temas e utilitários
├── data/          # Fontes de dados, modelos e repositórios concretos
├── domain/        # Entidades, casos de uso e contratos
└── presentation/  # Telas, widgets e gerenciamento de estado
```

## 🛠️ Stack Tecnológico

 * Framework: Flutter (Dart)
 * Gerenciamento de Estado: MobX / Provider
 * Injeção de Dependências: GetIt
 * Navegação: GoRouter
 * Utilitários: url_launcher, flutter_svg

## ⚙️ Como Executar o Projeto

### Pré-requisitos

 * Flutter SDK instalado (versão 3.19 ou superior)
 * Emulador Android/iOS ou dispositivo físico configurado.

### Passo a Passo

#### 1. Clone o repositório

git clone [https://github.com/Kainato/portfolio.git](https://github.com/Kainato/portfolio.git)

#### 2. Entre no diretório do projeto

cd portfolio

#### 3. Instale as dependências

flutter pub get

#### 4. Execute o aplicativo

flutter run

## 📬 Contato
 * GitHub: @Kainato
 * LinkedIn: Perfil Profissional
 * E-mail: contato@example.com
