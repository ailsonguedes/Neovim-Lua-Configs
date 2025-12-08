# NeoVim Configs - 🌑 

[![License: GPLV3](https://img.shields.io/badge/License-GPLV3-red.svg)](https://www.gnu.org/licenses/gpl-3.0.html) ![Neovim](https://img.shields.io/badge/NeoVim-%2357A143.svg?&style=for-the-badge&logo=neovim&logoColor=white) ![Lua](https://img.shields.io/badge/lua-%232C2D72.svg?style=for-the-badge&logo=lua&logoColor=white) ![Python](https://img.shields.io/badge/python-3670A0?style=for-the-badge&logo=python&logoColor=ffdd54) ![Haskell](https://img.shields.io/badge/Haskell-5e5086?style=for-the-badge&logo=haskell&logoColor=white) ![Linux](https://img.shields.io/badge/Linux-FCC624?style=for-the-badge&logo=linux&logoColor=black)

Esta é a configuração pessoal do Neovim 0.9+ (composta majoritariamente em Lua), utilizando o Paq-nvim como gerenciador de pacotes. O objetivo é criar um ambiente de desenvolvimento rápido e eficiente, focado em **LSP (Language Server Protocol)**, autocomplete e produtividade no terminal, com foco inicial em Python e Haskell.

## O que este projeto faz? 

Este projeto transforma o Neovim em um IDE leve e funcional, configurando os seguintes recursos principais:

- Gerenciamento de Pacotes: `paq-nvim`.

- Barra de Status: `lualine.nvim` (Tema Tokyonight).

- Navegação de Arquivos: `nvim-tree.lua`.

- LSP: Configuração `nvim-lspconfig` para `pyright` (Python) e `hls` (Haskell).

- Autocomplete/Snippets: `nvim-cmp` e `cmp-nvim-lsp`.

Erros em Tempo Real: `ALE` (Asynchronous Lint Engine).

Pesquisa Fuzzy: `telescope.nvim`.

## Como eu rodo ele na minha máquina? (Instalação)

A instalação requer o Neovim (versão 0.9.0 ou superior), Git e uma chave SSH configurada para clonar repositórios privados/públicos (recomendado para maior segurança e velocidade).

### Pré-requisitos
1. Instale o Neovim (v0.9.0+).

2. Instale o Git.

3. Configure sua Chave SSH com o GitHub.

### A. Limpeza (Recomendado)
Antes de instalar, remova quaisquer configurações antigas para evitar conflitos de caminho:

```bash
# Apaga configurações antigas, se existirem
rm -rf ~/.config/nvim
rm -rf ~/.local/share/nvim
```

### B. Clonagem e Instalação

1. Clone o Repositório: Clone este repositório para o local padrão de configuração do Neovim: 

```bash
git clone git@github.com:SeuUsuario/SeuRepositorio.git ~/.config/nvim
```

2. Inicie o Neovim: Abra o Neovim pela primeira vez.

```bash
nvim
```

O bloco de bootstrap (inicialização) no init.lua irá clonar e instalar o paq-nvim automaticamente.

3. Sincronização de Plugins: O Neovim provavelmente abrirá com a barra de comandos. Execute o comando de sincronização: 

```bash
:PaqSync
```

O `PaqSync` baixará todos os plugins listados, como `lualine`, `nvim-lspconfig`, e `nvim-cmp`.

4. Reinicie o Neovim: Feche e abra o Neovim novamente para que todas as configurações entrem em vigor.

Use `:q` para sair 
```bash
:q
```

ou `:wq` para salvar e sair

```bash
:wq
```

O tema tokyonight e a barra lualine devem carregar corretamente.

## Como eu uso? (Exemplos básicos)

Aqui estão alguns dos atalhos mais comuns configurados:

| Ação | Atalho (Normal Mode) | Plugin | Descrição |
| :--- | :--- | :--- | :--- |
| **Pesquisa de Arquivos** | `<leader>ff` | `telescope` | Abre o finder para buscar arquivos no projeto. |
| **Pesquisa de Texto** | `<leader>fg` | `telescope` | Procura texto em todos os arquivos (`live_grep`). |
| **Navegação de Buffers** | `<leader>fb` | `telescope` | Lista todos os buffers abertos. |
| **Árvore de Arquivos** | `<leader>n` ou `<C-n>` | `nvim-tree` | Abre/fecha a barra lateral do explorador de arquivos. |
| **Autocomplete** | `<C-Space>` | `nvim-cmp` | Força a exibição do menu de autocompletar. |
| **Confirmar Comp** | `<CR>` (Enter) | `nvim-cmp` | Confirma a seleção do menu de autocompletar. |

## Configurações Específicas de Linguagem

- Python: O Language Server pyright é iniciado automaticamente em qualquer arquivo .py.

- Haskell: O Language Server hls (Haskell Language Server) é iniciado automaticamente para arquivos Haskell.

## Como contribuo?

Sinta-se à vontade para sugerir melhorias, correções de bugs ou adições de plugins!

1. Faça um Fork deste repositório.

2. Crie uma Branch para sua feature (`git checkout -b feature/minha-feature`).

3. Commit suas mudanças (`git commit -m 'feat: Adiciona plugin X'`).

4. Faça Push para a branch (`git push origin feature/minha-feature`).

5. Abra um Pull Request.