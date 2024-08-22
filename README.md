# Corelab App Challenge

Bem-vindo ao Desafio do Aplicativo Corelab! Este projeto é uma aplicação Flutter desenvolvida para implementar a página de pesquisa de produtos, com base em um mockup Figma fornecido.

## Imagens do App
<p align="center">
  <img src="https://github.com/EduardoBento05/corelab_app_challenge/blob/main/assets/images/1.png" width="300">
  <img src="https://github.com/EduardoBento05/corelab_app_challenge/blob/main/assets/images/2.png" width="300">
  <img src="https://github.com/EduardoBento05/corelab_app_challenge/blob/main/assets/images/3.png" width="300">
    <img src="https://github.com/EduardoBento05/corelab_app_challenge/blob/main/assets/images/4.png" width="300">
    <img src="https://github.com/EduardoBento05/corelab_app_challenge/blob/main/assets/images/5.png" width="300">
    <img src="https://github.com/EduardoBento05/corelab_app_challenge/blob/main/assets/images/6.png" width="300">
</p>

## Visão Geral do Projeto

Este aplicativo tem como objetivo fornecer uma interface intuitiva para a pesquisa de produtos relacionados a dentistas. Utilizando o Flutter, a página de pesquisa permite aos usuários buscar produtos por título, descrição, preço ou categoria e visualizar os resultados de forma visual.

## Requisitos

1. **Tipo de Aplicativo:** Flutter
2. **Tarefa:** Implementar a página de pesquisa de produtos para o mockup Figma do Desafio do Aplicativo Corelab.

## Funcionalidades

- **Barra de Pesquisa:** Permite que os usuários pesquisem produtos que correspondam ao título, descrição, preço ou categoria do produto.
- **Resultados da Pesquisa:** Exibe os resultados da pesquisa de forma visual. Se nenhum resultado for encontrado, uma mensagem informará ao usuário.
- **Navegação:**
  - Botão na parte inferior da página para navegar até a página de detalhes do produto.
  - Ícone de categorias para navegar até a página de categorias.

## Componentes da Aplicação

### HomeScreen

- **Barra de Pesquisa:** Implementada com um `TextField` e `IconButton`, permitindo aos usuários realizar buscas e ver os resultados filtrados com base no texto digitado.
- **Lista de Anúncios:** Exibe os anúncios filtrados com base na busca do usuário.

### CategoryScreen

- **Tela de Categorias:** Exibe uma lista de categorias obtidas do banco de dados. Cada categoria é apresentada como um item de lista clicável, que pode levar a páginas relacionadas ou detalhes adicionais.

### AnnouncementScreen

- **Tela de Anúncios:** Exibe uma lista de anúncios com detalhes como imagem, título e categoria. Os anúncios são carregados do banco de dados e exibidos em um formato visualmente atraente.

### Gerenciamento de Estado e Tecnologias/Ferramentas utilizadas
- **Gerenciamento de Estado:** Utiliza setState para atualizar a UI com base nas mudanças nos dados carregados do banco de dados.
- **Banco de Dados:** Usa sqflite para simular o funcionamento dinâmico da aplicação com armazenamento local de categorias e anúncios.
- **Seleção de Imagens:** A biblioteca image_picker é usada para selecionar imagens para os anúncios.

## Instalação

Para rodar o aplicativo, siga as instruções abaixo:

1. **Clone o Repositório:**
   ```bash
   git clone https://github.com/EduardoBento05/corelab_app_challenge.git

2. **Instale as dependências:**
    ```sh
    flutter pub get
    ```
3. **Execute o aplicativo:**
    ```sh
    flutter run

## Requisitos de Ambiente de Desenvolvimento

- Para emular o aplicativo no Android, instale o [Android Studio](https://developer.android.com/studio).
- Para compilar aplicativos Flutter para Windows, instale o [Visual Studio](https://visualstudio.microsoft.com/).

## Versão do Flutter Utilizada

```plaintext
Flutter 3.22.2 • channel stable • https://github.com/flutter/flutter.git
Framework • revision 761747bfc5 (6 weeks ago) • 2024-06-05 22:15:13 +0200
Engine • revision edd8546116
Tools • Dart 3.4.3 • DevTools 2.34.3
