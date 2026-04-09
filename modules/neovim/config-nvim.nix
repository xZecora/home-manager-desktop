{ _, ... }:

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
vim.opt.showbreak = '=>'

vim.cmd('set mouse=')

vim.cmd('set undofile')
--vim.opt.background = 'dark'

vim.highlight.CursorLineNr = {term=bold, ctermbg=238, term=none}

vim.cmd('au TextYankPost * silent! lua vim.highlight.on_yank()')

vim.cmd('hi NonText guifg=#50FA7B')

--vim.cmd('hi Normal ctermbg=NONE')
vim.g.neovide_opacity = 0.8

vim.cmd('hi CursorLine guibg=#44475A gui=bold')
vim.cmd('hi CursorLineNr guifg=#FFB86C guibg=#44475A gui=bold')

vim.cmd('hi Conceal guifg=#F1FA8C guibg=NONE')

vim.cmd('au BufNewFile,BufRead * setlocal shiftwidth=2')
vim.cmd('au BufNewFile,BufRead * setlocal softtabstop=2')
vim.cmd('au BufNewFile,BufRead * setlocal tabstop=2')
--vim.cmd('au BufNewFile,BufRead * :TSEnable highlight')

vim.cmd('autocmd BufRead,BufEnter * set formatoptions-=cro')

vim.cmd('hi Comment guifg=#E79246')
vim.api.nvim_set_hl(0, "@comment", {link = "Comment"})

vim.cmd('set foldmethod=syntax')

function HighlightedFoldtext()
  local pos = vim.v.foldstart
  local line = vim.api.nvim_buf_get_lines(0, pos - 1, pos, false)[1]
  local lang = vim.treesitter.language.get_lang(vim.bo.filetype)
  local parser = vim.treesitter.get_parser(0, lang)
  local query = vim.treesitter.query.get(parser:lang(), "highlights")

  if query == nil then
    return vim.fn.foldtext()
  end

  local tree = parser:parse({ pos - 1, pos })[1]
  local result = {}

  local line_pos = 0

  local prev_range = nil

  for id, node, _ in query:iter_captures(tree:root(), 0, pos - 1, pos) do
    local name = query.captures[id]
    local start_row, start_col, end_row, end_col = node:range()
    if start_row == pos - 1 and end_row == pos - 1 then
      local range = { start_col, end_col }
      if start_col > line_pos then
        table.insert(result, { line:sub(line_pos + 1, start_col), "Folded" })
      end
      line_pos = end_col
      local text = vim.treesitter.get_node_text(node, 0)
      if prev_range ~= nil and range[1] == prev_range[1] and range[2] == prev_range[2] then
        result[#result] = { text, "@" .. name }
      else
        table.insert(result, { text, "@" .. name })
      end
      prev_range = range
    end
  end

  return result
end

local bg = vim.api.nvim_get_hl(0, { name = "StatusLine" }).bg
local hl = vim.api.nvim_get_hl(0, { name = "Folded" })
hl.bg = bg
vim.api.nvim_set_hl(0, "Folded", hl)

vim.opt.foldtext=[[luaeval('HighlightedFoldtext')()]]

local folds_augroup = vim.api.nvim_create_augroup("Folds", { clear=true })

vim.api.nvim_create_autocmd("BufReadPre", {
    group = folds_augroup,
    command = "setlocal foldmethod=syntax"
})

vim.api.nvim_create_autocmd("BufEnter", {
    group = folds_augroup,
    command = "setlocal foldmethod=manual"
})

--vim.opt.formatoptions:remove('c')
--vim.opt.formatoptions:remove('r')
--vim.opt.formatoptions:remove('o')
--vim.cmd("set formatoptions-=cro")

vim.api.nvim_create_autocmd({ "FileType" }, {
  group = vim.api.nvim_create_augroup("FormatOptions", { clear = true }),
  pattern = { "*" },
  callback = function()
    vim.opt_local.fo:remove("c")
    vim.opt_local.fo:remove("o")
  end,
})

--vim.api.nvim_create_autocmd("QuitPre", {
    --group = folds_augroup,
    --command = "mkview | filetype detect | set foldmethod=manual"
--})

--vim.api.nvim_create_autocmd("BufLeave", {
    --group = folds_augroup,
    --command = "mkview"
--})

--vim.api.nvim_create_autocmd("BufWinLeave", {
    --group = folds_augroup,
    --command = "mkview | filetype detect | set foldmethod=manual"
--})

--vim.api.nvim_create_autocmd("BufWinEnter", {
    --group = folds_augroup,
    --command = "silent! loadview | filetype detect | set foldmethod=manual"
--})

--vim.api.nvim_create_autocmd("BufEnter", {
    --group = folds_augroup,
    --command = "silent! normal! g`\""
--})

--vim.cmd("if argc() ==# 0 \
--  silent execute 'edit .' \
--endif")'';

  };
}
