<p align="center">
  <img src="./static/portocred-website-cover.svg" /> 
  <br />
  <br />
  <a href="#pré-requisitos"> Pré-requisitos </a> //
  <a href="#setup"> Setup </a> //
  <a href="#up--running"> Up & Running </a> //
  <a href="#scripts"> Scripts </a> //
  <a href="#estrutura"> Estrutura </a> //
  <a target="_blank" href="https://stg-portocred-website.netlify.app/"> Staging </a>
 </p>

## Pré-requisitos

- Node `v14.x.x`
- Yarn `v1`

## Setup

Environment variables:

```sh
 cp .env.example .env.local
```

Install node dependencies:

```sh
 yarn
```

## Up & Running

1. Compilar os arquivos ReScript com as depedências:

```sh
  yarn rescript:build
```

2. Executar o server de dev do `next`:

```sh
 yarn dev
```

## Scripts

| Script            | Descrição                                                     |
| ----------------- | ------------------------------------------------------------- |
| `rescript:watch`  | Executa o compilador do ReScript em `watch mode`              |
| `rescript:build`  | Executa o build do compilador do ReScript                     |
| `rescript:clean`  | Limpa todos os arquivos geradores pelo compilador do ReScript |
| `rescript:format` | Formata todos os arquivos ReScript                            |
| `next:dev`        | Executa o dev server do next                                  |
| `next:build`      | Executa o build do next                                       |
| `prettier`        | Formata os arquivos `.js,.md,.json` usando prettier           |

## Estrutura

```
├── pages
├── static
├── src
   |─── ui
   |─── components
   |─── bindings
   |─── lib
   |──- pages
```

| Folder           | Description                                                                                                                      |
| ---------------- | -------------------------------------------------------------------------------------------------------------------------------- |
| `pages`          | Páginas do next, não é utilizada para implementações, funciona apenas como um link para as páginas geradas pelos arquivos `.res` |
| `src`            | Pasta onde ficam todas as implementações, páginas, componentes, etc utilizando ReScript                                          |
| `src/components` | Pasta onde ficam todos os componentes utilizados pelas páginas e outros componentes da plataforma                                |
| `src/ui/`        | Pasta onde ficam os componets do DS (_:warning: Abordagem temporária até criarmos e publicarmos em um pacote dedicado ao DS_)    |
| `src/bindings/`  | Pasta onde ficam todos os bindings e modulos que fazem interoperabilidade com outras bibliotecas JS/TS                           |
| `src/lib/`       | Pasta para módulos que são compartilhados entre outros módulos da aplicação                                                      |
| `src/pages/`     | Page components que são renderizados pelas páginas da pasta `pages/` na raíz do projeto.                                         |

## Environment variables

| Variable Name | Description |
| ------------- | ----------- |
|               |             |