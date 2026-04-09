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

map('n', '<A-e>', ':m+<cr>', {silent = true})
map('n', '<A-i>', ':m-2<cr>', {silent = true})

map('n', '<leader><cr>', ':noh<cr>', {silent = true})
map('n', '<leader>q', ':bp<BAR>bd#<cr>', {noremap = true, silent = true})

map('n', '<leader>j', ':bprev<CR>', {silent = true})
map('n', '<leader>k', ':bnext<CR>', {silent = true})

map('n', '<leader>ff', ':Telescope find_files<cr>', {silent = true})
map('n', '<leader>fg', ':Telescope live_grep<cr>', {silent = true})
map('n', '<leader>ft', ':Telescope buffers<cr>', {silent = true})
map('n', '<leader>fh', ':Telescope help_tags<cr>', {silent = true})

map('n', '<leader>nt', ':NvimTreeToggle<cr>', {silent = true})
map('n', '<leader>nf', ':NvimTreeFocus<cr>', {silent = true})
map('n', 'q:', "")

map('n', '<leader>tt', ':Oil --float<cr>', {silent = true})

map('n', '<leader>w', '<C-w>', {silent = true})
map('n', '<leader>e', ':bnext<CR>', {silent = true})
map('n', '<leader>i', ':bprev<CR>', {silent = true})

map('n', '<leader>xx', '<cmd>Trouble diagnostics toggle<cr>', {silent = true})
map('n', '<leader>xX', '<cmd>Trouble diagnostics toggle filter.buf=0<cr>', {silent = true})
map('n', '<leader>cs', '<cmd>Trouble symbols toggle focus=false<cr>', {silent = true})
map('n', '<leader>cl', '<cmd>Trouble lsp toggle focus=false win.position=right<cr>', {silent = true})
map('n', '<leader>xL', '<cmd>Trouble loclist toggle<cr>', {silent = true})
map('n', '<leader>xQ', '<cmd>Trouble qflist toggle<cr>', {silent = true})


vim.keymap.set({ 'n' }, '<leader>ca', vim.lsp.buf.code_action, {})

--map('n', '<leader>p', 'i\\begin{proof}<CR>\\end{proof}<Esc>O', {silent=true})

--vim.cmd('noremap :W :w')
--vim.cmd('noremap :Q :q')

vim.cmd('autocmd BufEnter *.tex nnoremap <buffer> <leader>pp i\\begin{proof}<CR>\\end{proof}<Esc>O')
vim.cmd('autocmd BufEnter *.tex nnoremap <buffer> <leader>pr i\\begin{proposition}<CR>\\end{proposition}<Esc>O')
vim.cmd('autocmd BufEnter *.tex nnoremap <buffer> <leader>pt i\\begin{theorem}<CR>\\end{theorem}<Esc>O')
vim.cmd('autocmd BufEnter *.tex nnoremap <buffer> <leader>ps i\\begin{problem}<CR>\\end{problem}<Esc>O')

--vim.cmd(':nn cuw ciw')

vim.cmd(':nn u i')
vim.cmd(':nn n h')
vim.cmd(':nn e j')
vim.cmd(':nn i k')
vim.cmd(':nn o l')

vim.cmd(':no n h')
vim.cmd(':no N H')
vim.cmd(':no e j')
vim.cmd(':no ge gj')
vim.cmd(':no E J')
vim.cmd(':noremap i k')
vim.cmd(':no gi gk')
vim.cmd(':noremap I K')
vim.cmd(':no o l')
vim.cmd(':no O L')

vim.cmd(':no h n')
vim.cmd(':no H N')
vim.cmd(':no f e')
vim.cmd(':no F E')
vim.cmd(':no ; e')
vim.cmd(':no ; E')
vim.cmd(':noremap u i')
vim.cmd(':noremap U I')
vim.cmd(':no l o')
vim.cmd(':no L o')

vim.cmd(':nn ge gj')
vim.cmd(':nn gj ge')
vim.cmd(':nn gi gk')
vim.cmd(':nn gk gi')

vim.cmd(':nn l o')
vim.cmd(':nn L O')
vim.cmd(':nn k u')
'';
  };
}
