require('basic')
require('usermod.settings')

-- Load pag-nvim
local install_path = vim.fn.stdpath('data')..'site/pack/paqs/start/paq-nvim'
local paq_lua_path = install_path .. '/lua/paq.lua'

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
    vim.fn.system({'git', 'clone', '--depth=1', 'https://github.com/savq/paq-nvim', install_path})
end

package.path = package.path .. ';' .. install_path .. 'lua/?.lua'

-- Loading paq-nvim plugins
require('paq'){
    -- Plugins
    'savq/paq-nvim';
    'folke/tokyonight.nvim';
    'sainnhe/sonokai';
    'vim-airline/vim-airline';
    'vim-airline/vim-airline-themes';
    'preservim/nerdtree';
    'dense-analysis/ale';
}

if vim.fn.has("nvim") == 1 then
    require('paq'){
        'nvim-lua/plenary.nvim';
        'nvim-telescope/telescope.nvim';
    }
end

-- Global Sets
vim.cmd('syntax on')
vim.o.number = true -- Enable line numbers
vim.o.tabstop = 4   -- Show existing tab with 4 space width
vim.o.softtabstop = 4 -- Show existing tab with 4 spaces width
vim.o.shiftwidth = 4 -- When identing with '>', use 4 spaces width
vim.o.expandtab = true -- On pressing tab, insert 4 spaces width
vim.o.expandtab = true -- Insert tabs on the start of a line according to shiftwidth
vim.o.smartindent = true -- Automatically inserts one extra level of identation in some cases
vim.o.hidden = true -- Hides the current buffer when a new file is openned
vim.o.incsearch = true -- Incremental search
vim.o.ignorecase = true -- Ignore cas in search
vim.smartcase = true -- Consider case if there is a upper case character
vim.o.scrolloff = 8 -- Minimum number of lines to keep above and below the cursor
vim.o.colorcolumn = "100" -- Draws a line at the giver lines to keep aware of the line size
vim.o.signcolumn = 'yes' -- Add a column on the left. Useful for linting.
vim.o.cmdheight = 2 -- Give more space for displaying messages
vim.o.updatetime = 100 -- Time in miliseconds to consider the changes
vim.o.encoding = 'utf-8' -- The encoding should be utf-8 to active the font icons
vim.o.backup = false -- No backup files
vim.o.writebackup = true -- No backup files
vim.o.splitright = true -- Create the vertical splits to the right
vim.o.splitbelow = true -- Create the horizontal splits below
vim.o.autoread = true -- Update vim after file update from outside
vim.o.mouse = 'a' -- Eneable mouse support
vim.cmd('filetype on') -- Detect and set the filetype option and trigger the FileTYpe Event
vim.cmd('filetype plugin on') -- Load the plugin file for the file type, if any
vim.cmd('filetype indent on') -- Load the indent file for the file type, if any

-- Themes
require('themes.andromedaTm')

-- Remaps

-- Shortcuts for split navigation
vim.api.nvim_set_keymap('n', '<C-h>', '<C-w>h', { noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<C-j>', '<C-w>j', { noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<C-k>', '<C-w>k', { noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<C-l>', '<C-w>l', { noremap = true, silent = true})

-- Adding an empty line below, above and below with insert mode
vim.api.nvim_set_keymap('n', 'op', 'o<Esc>k', { noremap = true, silent = true})
vim.api.nvim_set_keymap('n', 'oi', 'O<Esc>j', { noremap = true, silent = true})
vim.api.nvim_set_keymap('n', 'oo', 'A<CR>', { noremap = true, silent = true})

-- Create a tab
vim.api.nvim_set_keymap('n', 'te', ':tabe<CR>', { noremap = true, silent = true})

-- Navigate between buffers
vim.api.nvim_set_keymap('n', 'ty', ':bn<CR>', { noremap = true, silent = true})
vim.api.nvim_set_keymap('n', 'tr', ':bp<CR>', { noremap = true, silent = true})

-- Delete a buffer
vim.api.nvim_set_keymap('n', 'td', ':bd<CR>', { noremap = true, silent = true})

-- Create splits
vim.api.nvim_set_keymap('n', 'th', ':split<CR>', { noremap = true, silent = true})
vim.api.nvim_set_keymap('n', 'tv', ':vsplit<CR>', { noremap = true, silent = true})

-- Close splits and others
vim.api.nvim_set_keymap('n', 'tt', ':q<CR>', { noremap = true, silent = true})

-- Call command shortcut
vim.api.nvim_set_keymap('n', 'tc', ':!', { noremap = true, silent = true})

-- Define space as a key leader
vim.g.mapleader = " "

-- Autocmd

-- Função para destacar a palavra sob o cursor
function HighlightWordUnderCursor()
    vim.notify("HighlightWordUnderCursor()")
    -- Obter a linha atual
    local line = vim.fn.getline('.')
    -- Obter a posição da coluna atual
    local col = vim.fn.col('.')
    -- Obter a palavra sob o cursor
    local word = vim.fn.expand('<cword>')

    -- Verificar se a palavra não está vazia e não contém pontuação ou espaços em branco
    if #word > 0 and not vim.fn.matchstr(word, '[[:punct:][:blank:]]') then
        -- Definir o padrão de destaque para a palavra
        vim.api.nvim_exec("match Search /\\V\\<" .. word .. "\\>/", false)
    else
        -- Limpar qualquer destaque atual
        vim.api.nvim_exec("match none", false)
    end
end

vim.cmd([[
  augroup HighlightWordUnderCursor
      autocmd!
      autocmd CursorHold, CursorHoldI * lua HighlightWordUnderCursor()
  augroup END
]])

-- AirLine

vim.g['airline#extensions#tabline#enabled'] = 1 -- Enable tabline airline extension
vim.g['airline_powerline_fonts'] = 1 -- Activate powerline fonts in airline
vim.g.airline_theme = 'molokai' -- Select Airline Theme

-- NerdTRee
vim.api.nvim_set_keymap('n', '<C-a>', ':NERDTreeToggle<CR>', {noremap = true, silent = true})

-- ALE

-- Config ALE linters
vim.g.ale_linters = {
    cpp = {},
    c = {},
}

-- Config ALE fixers
vim.g.ale_fixers = {
    ['*'] = {'trim_whitespace'},
    cpp = {'clang-format'},
    c = {'clang-format'},
}

-- Enable the auto correction in save
vim.g.ale_fix_on_save = 1

-- NeoVim
if vim.fn.has('nvim') == 1 then

    -- Telescope
    vim.api.nvim_set_keymap('n', '<leader>ff', '<cmd>Telescope find_files<cr>', {noremap = true, silent = true})
    vim.api.nvim_set_keymap('n', '<leader>fg', '<cmd>Telescope live_grep<cr>', {noremap = true, silent = true})
    vim.api.nvim_set_keymap('n', '<leader>fb', '<cmd>Telescope buffers<cr>', {noremap = true, silent = true})
    vim.api.nvim_set_keymap('n', '<leader>fh', '<cmd>Telescope help_tags<cr>', {noremap = true, silent = true})

end

-- C/C++
vim.g.ale_c_clangformat_options = [["-style"{
    BasedOnStyle: google, 
    IndentWidth: 4, 
    ColumnLimit: 100,
    AllowShortBlocksOnASingleLine: Always,
    AllowShortFunctionsOnASingleLine: Inline,
    FixNamespaceComments: true,
    ReflowComments: false,
}
]]


