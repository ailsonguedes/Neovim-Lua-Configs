lua << EOF
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
    }

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
    vim.o.colorcolumn = 100 -- Draws a line at the giver lines to keep aware of the line size 
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
    vim.o.filetype = true -- Detect and set the filetype option and trigger the FileTYpe Event
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


EOF

