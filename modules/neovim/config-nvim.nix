{ config, pkgs, ... }:

{

  programs.neovim = 
  let
    toLua = str: "lua << EOF\n${str}\nEOF\n";
  in
  { 
  extraConfig = toLua ''
vim.opt.writebackup = false
vim.switchbuf = 'useopen,usetab,newtab'
vim.splitright = true
vim.opt.scrolloff = 5
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.clipboard = 'unnamedplus'
vim.opt.syntax = 'enable'

vim.opt.linebreak = true

vim.opt.conceallevel = 2

vim.opt.autoread = true

vim.opt.backupdir='/home/vitrial/.config/nvim/backup/'
vim.opt.directory='/home/vitrial/.config/nvim/swp'
vim.opt.undodir='/home/vitrial/.config/nvim/undo'

vim.opt.hlsearch = true

vim.opt.cursorline = true

vim.opt.expandtab = true
vim.opt.smarttab = true

vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.tabstop = 2

vim.opt.wrap = true

vim.opt.breakindentopt = 'shift:2,min:40,sbr'
vim.opt.formatoptions = 'l'
vim.cmd("set formatoptions-=cro")
vim.opt.showbreak = '=>'

vim.cmd('set undofile')
vim.opt.background = 'dark'

vim.highlight.CursorLineNr = {term=bold, ctermbg=238, term=none}

vim.cmd('au TextYankPost * silent! lua vim.highlight.on_yank()')

vim.cmd('hi NonText guifg=#50FA7B')

vim.cmd('hi Normal ctermbg=NONE')
vim.g.neovide_transparency = 0.8

vim.cmd('hi CursorLine guibg=#44475A gui=bold')
vim.cmd('hi CursorLineNr guifg=#FFB86C guibg=#44475A gui=bold')

vim.cmd('hi Conceal guifg=#F1FA8C guibg=NONE')

vim.cmd('au BufNewFile,BufRead * setlocal shiftwidth=2')
vim.cmd('au BufNewFile,BufRead * setlocal softtabstop=2')
vim.cmd('au BufNewFile,BufRead * setlocal tabstop=2')
--vim.cmd('au BufNewFile,BufRead * :TSEnable highlight')

vim.cmd('autocmd BufNewFile,BufRead * setlocal formatoptions-=cro')

vim.cmd('hi Comment guifg=#E79246')
vim.api.nvim_set_hl(0, "@comment", {link = "Comment"})

vim.cmd("if argc() ==# 0 \
  silent execute 'edit .' \
endif")'';

  };
}
