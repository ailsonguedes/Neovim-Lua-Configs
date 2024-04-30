-- Verificar se o suporte a cores verdadeiras está disponível
if vim.fn.exists('+termguicolors') == 1 then
    -- Definir os códigos de escape para cores verdadeiras
    vim.api.nvim_command('let &t_8f = "\\27[38;2;%lu;%lu;%lum"')
    vim.api.nvim_command('let &t_8b = "\\27[48;2;%lu;%lu;%lum"')
    
    -- Habilitar cores verdadeiras
    vim.o.termguicolors = true
end

vim.g.sonokai_style = 'andromeda'
vim.g.sonokai_enable_italic = 1
vim.g.sonokai_disable_italic_comment = 0
vim.g.sonokai_diagnostic_line_highlight = 1
vim.g.sonokai_current_word = 'bold'
vim.cmd('colorscheme sonokai')

-- Set transparency
if vim.fn.has('nvim') == 1 then
    vim.cmd('highlight Normal guibg=NONE ctermbg=NONE')
    vim.cmd('highlight EndOfBuffer guibg=NONE ctermbg=NONE')
end

vim.g.airline_theme = 'sonokai'

