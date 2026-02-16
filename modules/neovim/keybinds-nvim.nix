{ config, pkgs, ... }:

{

  programs.neovim = 
  let
    toLua = str: "lua << EOF\n${str}\nEOF\n";
  in
  { 
  extraConfig = toLua ''
local function map(mode, combo, mapping, opts)
  local options = {noremap = true}
  if opts then
    options = vim.tbl_extend('force', options, opts)
  end
  vim.api.nvim_set_keymap(mode, combo, mapping, options)
end

vim.g.mapleader = ' '

map('n', '<C-j>', '<C-Down>')
map('n', '<C-k>', '<C-Up>')

map('n', '<leader>v', ':set relativenumber! number!<CR>', {silent = true})

map('n', '<A-l>', 'mpo<Esc>`p:delm p<cr>', {silent = true})
map('n', '<A-L>', 'mpO<Esc>`p:delm p<cr>', {silent = true})

map('n', '<A-j>', ':m+<cr>', {silent = true})
map('n', '<A-k>', ':m-2<cr>', {silent = true})

map('n', '<leader><cr>', ':noh<cr>', {silent = true})
map('n', '<leader>q', ':bp<BAR>bd#<cr>', {noremap = true, silent = true})

map('n', '<leader>j', ':bprev<CR>', {silent = true})
map('n', '<leader>k', ':bnext<CR>', {silent = true})

map('n', '<leader>ff', ':Telescope find_files<cr>', {silent = true})
map('n', '<leader>fg', ':Telescope live_grep<cr>', {silent = true})
map('n', '<leader>ft', ':Telescope buffers<cr>', {silent = true})
map('n', '<leader>fh', ':Telescope help_tags<cr>', {silent = true})

--map('n', '<leader>tt', ':NvimTreeToggle<cr>', {silent = true})
--map('n', '<leader>tf', ':NvimTreeFocus<cr>', {silent = true})
--map('n', 'q:', "")

map('n', '<leader>tt', ':Oil --float<cr>', {silent = true})

map('n', '<leader>mm', ':MinimapToggle<cr>', {silent = true})

map('n', '<leader>w', '<C-w>', {silent = true})
map('n', '<leader>e', ':bnext<CR>', {silent = true})
map('n', '<leader>i', ':bprev<CR>', {silent = true})

vim.keymap.set({ 'n' }, '<leader>ca', vim.lsp.buf.code_action, {})

--map('n', '<leader>p', 'i\\begin{proof}<CR>\\end{proof}<Esc>O', {silent=true})

vim.cmd('autocmd BufEnter *.tex nnoremap <buffer> <leader>pp i\\begin{proof}<CR>\\end{proof}<Esc>O')
vim.cmd('autocmd BufEnter *.tex nnoremap <buffer> <leader>pr i\\begin{proposition}<CR>\\end{proposition}<Esc>O')
vim.cmd('autocmd BufEnter *.tex nnoremap <buffer> <leader>pt i\\begin{theorem}<CR>\\end{theorem}<Esc>O')
vim.cmd('autocmd BufEnter *.tex nnoremap <buffer> <leader>ps i\\begin{problem}<CR>\\end{problem}<Esc>O')

vim.cmd(':nn cuw ciw')

vim.cmd(':nn u i')
vim.cmd(':nn n h')
vim.cmd(':nn e gj')
vim.cmd(':nn i gk')
vim.cmd(':nn o l')

vim.cmd(':no n h')
vim.cmd(':no N H')
vim.cmd(':no e gj')
vim.cmd(':no E J')
vim.cmd(':no i gk')
vim.cmd(':no I K')
vim.cmd(':no o l')
vim.cmd(':no O L')

vim.cmd(':no h n')
vim.cmd(':no H N')
vim.cmd(':no j e')
vim.cmd(':no J E')
vim.cmd(':no k i')
vim.cmd(':no K I')
vim.cmd(':no l o')
vim.cmd(':no L o')

vim.cmd(':nn ge gj')
vim.cmd(':nn gj ge')
vim.cmd(':nn gi gk')
vim.cmd(':nn gk gi')

vim.cmd(':nn l o')
vim.cmd(':nn L O')
vim.cmd(':nn h u')
'';
  };
}
