-- ============================================================================
-- INIT.LUA FINAL - CONFIGURAÇÃO COMPLETA
-- ============================================================================

-- 1. CONFIGURAÇÃO DE CAMINHOS E PAQ
-- ============================================================================

-- Configura paths para módulos customizados em ~/.config/nvim/lua/
local config_path = vim.fn.stdpath('config')
package.path = package.path .. ';' .. config_path .. '/lua/?.lua;' .. config_path .. '/lua/?/init.lua'

-- Garante que o Paq (e plugins) sejam instalados em ~/.local/share/nvim/ (DATA)
local install_path = vim.fn.stdpath('data') .. '/site/pack/paqs/start/paq-nvim'

-- Bootstrap do Paq (se não existir, clona via HTTPS para garantir)
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
    vim.fn.system({
        'git', 'clone', '--depth=1', 'https://github.com/savq/paq-nvim.git', install_path
    })
end

-- Carrega o Paq e adiciona o diretório de plugins ao runtimepath
vim.cmd("packadd paq-nvim")

-- 2. LISTA DE PLUGINS
-- ============================================================================
require("paq")({
    'savq/paq-nvim';

    -- Temas e UI
    { 'folke/tokyonight.nvim', url = 'git@github.com:folke/tokyonight.nvim.git' };
    { 'nvim-lualine/lualine.nvim', url = 'git@github.com:nvim-lualine/lualine.nvim.git' };
    { 'nvim-tree/nvim-web-devicons', url = 'git@github.com:nvim-tree/nvim-web-devicons.git' };
    { 'nvim-tree/nvim-tree.lua', url = 'git@github.com:nvim-tree/nvim-tree.lua.git' };
    
    -- Utilidades
    { 'dense-analysis/ale', url = 'git@github.com:dense-analysis/ale.git' };
    { 'nvim-lua/plenary.nvim', url = 'git@github.com:nvim-lua/plenary.nvim.git' };
    { 'nvim-telescope/telescope.nvim', url = 'git@github.com:nvim-telescope/telescope.nvim.git' };

    -- LSP & Autocomplete
    { 'neovim/nvim-lspconfig', url = 'git@github.com:neovim/nvim-lspconfig.git' };
    { 'hrsh7th/nvim-cmp', url = 'git@github.com:hrsh7th/nvim-cmp.git' };
    { 'hrsh7th/cmp-nvim-lsp', url = 'git@github.com:hrsh7th/cmp-nvim-lsp.git' };
    -- { 'hrsh7th/vim-vsnip' }; -- REMOVIDO TEMPORARIAMENTE PARA EVITAR ERROS

    -- Treesitter
    { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate', url = 'git@github.com:nvim-treesitter/nvim-treesitter.git' };
    
    -- Haskell
    { 'mrcjkb/haskell-tools.nvim', url = 'git@github.com:mrcjkb/haskell-tools.nvim.git' };
})

-- 3. CARREGAMENTO DE MÓDULOS CUSTOMIZADOS
-- ============================================================================
-- Tenta carregar 'basic' e 'usermod.settings' se existirem. 
-- O pcall impede que o Neovim quebre se os arquivos não existirem.
pcall(require, 'basic')
pcall(require, 'usermod.settings')

-- 4. CONFIGURAÇÕES GERAIS (Backup do basic.lua)
-- ============================================================================
vim.opt.number = true
vim.opt.relativenumber = true -- Opcional: números relativos
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.termguicolors = true -- Importante para o tokyonight
vim.opt.mouse = 'a'
vim.opt.signcolumn = 'yes'
vim.opt.encoding = 'utf-8'

-- 5. CONFIGURAÇÃO DOS PLUGINS
-- ============================================================================

-- Tema
vim.cmd('colorscheme tokyonight')

-- Lualine
require('lualine').setup {
    options = { theme = 'tokyonight' }
}

-- Nvim-Tree
require('nvim-tree').setup {}

-- Treesitter
require('nvim-treesitter.configs').setup {
    ensure_installed = { "c", "lua", "vim", "python", "haskell" },
    highlight = { enable = true },
}

-- ALE
vim.g.ale_linters = { cpp = {}, c = {} }
vim.g.ale_fixers = { ['*'] = {'trim_whitespace'} }

-- LSP Config (CORREÇÃO IMPORTANTE: usa 'lspconfig' e não 'nvim-lspconfig')
local lspconfig = require('lspconfig')

-- Configuração Python (Pyright)
lspconfig.pyright.setup{}

-- Configuração Haskell (HLS)
-- Nota: haskell-tools pode gerenciar isso automaticamente, mas aqui está o fallback
lspconfig.hls.setup{
    filetypes = { 'haskell', 'lhaskell', 'cabal' },
}

-- Nvim-CMP (Autocomplete)
local cmp = require('cmp')
cmp.setup({
    snippet = {
        -- Como removemos o vsnip, usamos uma função simples para evitar erro
        expand = function(args)
             -- vim.fn["vsnip#anonymous"](args.body) -- Desativado pois vsnip foi removido
        end,
    },
    mapping = cmp.mapping.preset.insert({
        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.abort(),
        ['<CR>'] = cmp.mapping.confirm({ select = true }), 
    }),
    sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        { name = 'buffer' },
    })
})

-- Telescope Keymaps
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})

print("Configuração carregada com sucesso!")
