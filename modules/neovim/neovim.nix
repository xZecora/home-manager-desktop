{ config, pkgs, ... }:

{
  imports = [
    ./config-nvim.nix
    ./keybinds-nvim.nix
  ];

  home.packages = with pkgs; [
    neovide
  ];

  home.sessionVariables = {
    EDITOR = "nvim";
  };

  xdg.mimeApps.defaultApplications = {
    "text/plain" = [ "neovide.desktop" ];
  };

  programs.neovim = 
  let
    toLua = str: "lua << EOF\n${str}\nEOF\n";
  in
  {
    enable = true;
    vimAlias = true;

    plugins = with pkgs.vimPlugins; [
      nvim-web-devicons
      vim-nix
      gruvbox
      plenary-nvim
      cmp_luasnip
      friendly-snippets
      nui-nvim
      cmp-buffer
      cmp-path
      cmp-cmdline
      cmp-nvim-lsp
      vim-nixhash
      vim-cool
      vim-fugitive
      {
        plugin = rainbow-delimiters-nvim;
        config = toLua ''
-- This module contains a number of default definitions
local rainbow_delimiters = require 'rainbow-delimiters'

---@type rainbow_delimiters.config
vim.g.rainbow_delimiters = {
    strategy = {
        [""] = rainbow_delimiters.strategy['global'],
        vim = rainbow_delimiters.strategy['local'],
    },
    query = {
        [""] = 'rainbow-delimiters',
        lua = 'rainbow-blocks',
    },
    priority = {
        [""] = 110,
        lua = 210,
    },
    highlight = {
        'RainbowDelimiterRed',
        'RainbowDelimiterYellow',
        'RainbowDelimiterBlue',
        'RainbowDelimiterOrange',
        'RainbowDelimiterGreen',
        'RainbowDelimiterViolet',
        'RainbowDelimiterCyan',
    },
}'';
      }
      {
        plugin = nvim-notify;
        config = toLua "vim.notify = require('notify')";
      }
      {
      plugin = obsidian-nvim;
      config = toLua ''
                require("obsidian").setup({
	                workspaces = {
		                {
			                name = "obsidian",
			                path = "~/Documents/obsidian",
		                },
	                },
                })'';
      }
      {
        plugin = ultimate-autopair-nvim;
        config = toLua "require('ultimate-autopair').setup()";
      }
      {
        plugin = lualine-nvim;
        config = toLua "require('lualine').setup({ options = {theme = 'PaperColor', },})";
      }
      {
        plugin = nvim-tree-lua;
        config = toLua ''local function my_on_attach(bufnr)
  local api = require "nvim-tree.api"
  local function opts(desc)
    return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
  end
  -- default mappings
  --api.config.mappings.default_on_attach(bufnr)

  -- custom mappings
  vim.keymap.set('n', '<CR>',    api.node.open.edit, opts('Open'))
  vim.keymap.set('n', 'a',    api.fs.create, opts('Create File or Directory'))
  vim.keymap.set('n', '=',   api.tree.change_root_to_node,        opts('CD'))
  vim.keymap.set('n', '-',       api.tree.change_root_to_parent,      opts('Up'))
  vim.cmd('hi NvimTreeNormal guibg=NONE')
end

-- pass to setup along with your other options
require("nvim-tree").setup({
  on_attach = my_on_attach,
})'';
      }
      {
        plugin = catppuccin-nvim;
        #config = "colorscheme catppuccin";
      }
      {
        plugin = papercolor-theme;
        #config = "colorscheme PaperColor";
      }
      {
        plugin = onedark-nvim;
        #config = "colorscheme onedark";
      }
      {
        plugin = gruvbox;
        #config = "colorscheme gruvbox";
      }
      {
        plugin = vim-deus;
        config = "colorscheme deus";
      }
      {
        plugin = material-vim;
        #config = "colorscheme material";
      }
      {
        plugin = srcery-vim;
        #config = "colorscheme srcery";
      }
      {
        plugin = tokyonight-nvim;
        #config = "colorscheme tokyonight";
      }
      {
        plugin = palenightfall-nvim;
        #config = "colorscheme palenightfall";
      }
      {
        plugin = vim-gitgutter;
      }
      (nvim-treesitter.withPlugins (p: [
        p.tree-sitter-nix
        p.tree-sitter-vim
        p.tree-sitter-vimdoc
        p.tree-sitter-bash
        p.tree-sitter-lua
        p.tree-sitter-odin
        p.tree-sitter-regex
        p.tree-sitter-markdown
        p.tree-sitter-c
      ]))
      {
        plugin = oil-nvim;
        config = toLua ''require('oil').setup({
            keymaps = {
              ["<Space>tt"] = "actions.close",
            },
            view_options = {
              show_hidden = true,
            },
          })
          '';
      }
      {
        plugin = vimtex;
        config = toLua ''vim.g.vimtex_view_method = "zathura"
                         vim.g.vimtex_quickfix_mode = 0
                         vim.g.vimtex_matchparan_enabled = 0'';
      }
      {
        plugin = telescope-nvim;
        config = toLua ''require('telescope').setup({
                           extensions = {
                             ["ui-select"] = {
                               require("telescope.themes").get_dropdown({}),
                             },
                           },
                         })'';
      }
      {
        plugin = telescope-ui-select-nvim;
        config = toLua "require('telescope').load_extension('ui-select')";
      }
      {
        plugin = noice-nvim;
        config = toLua "require('noice').setup()";
      }
      {
        plugin = nvim-lastplace;
        config = toLua "require('nvim-lastplace').setup();";
      }
      {
        plugin = nvim-lspconfig;
        config = toLua ''local lspconfig = require('lspconfig')
                         lspconfig.clangd.setup({})
                         lspconfig.lua_ls.setup({})
                         lspconfig.texlab.setup({})'';
      }
      {
        plugin = none-ls-nvim;
        config = toLua ''local null_ls = require('null-ls')
                         null_ls.setup({
                           sources = {
                             null_ls.builtins.formatting.stylua,
                             null_ls.builtins.diagnostics.proselint,
                           },
                         })'';
      }
      {
        plugin = luasnip;
        config = toLua ''require('luasnip.loaders.from_vscode').lazy_load()'';
      }
      {
        plugin = nvim-cmp;
        config = toLua ''local has_words_before = function()
	unpack = unpack or table.unpack
	local line, col = unpack(vim.api.nvim_win_get_cursor(0))
	return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

                   local luasnip = require('luasnip')
                   local cmp = require('cmp')
                   cmp.setup({
                   snippet = {
                     expand = function(args)
                       require("luasnip").lsp_expand(args.body)
                     end,
                   },
                   window = {
                     completion = cmp.config.window.bordered(),
                     documentation = cmp.config.window.bordered(),
                   },
                   mapping = {
                   ["<C-b>"] = cmp.mapping.scroll_docs(-4),
                   ["<C-f>"] = cmp.mapping.scroll_docs(4),
                   ["<C-Space>"] = cmp.mapping.complete(),
                   ["<A-q>"] = cmp.mapping.abort(),
                   ["<CR>"] = cmp.mapping.confirm({ select = true }),
                   ["<Tab>"] = cmp.mapping(function(fallback)
                                 if cmp.visible() then
                                   cmp.select_next_item()
                                 -- You could replace the expand_or_jumpable() calls with expand_or_locally_jumpable()
                                 -- that way you will only jump inside the snippet region
                                 elseif luasnip.expand_or_jumpable() then
                                   luasnip.expand_or_jump()
                                 elseif has_words_before() then
                                   cmp.complete()
                                 else
                                   fallback()
                                 end
                               end, { "i", "s" }),

                   ["<S-Tab>"] = cmp.mapping(function(fallback)
                                   if cmp.visible() then
                                     cmp.select_prev_item()
                                   elseif luasnip.jumpable(-1) then
                                     luasnip.jump(-1)
                                   else
                                     fallback()
                                   end
                                 end, { "i", "s" }),
                   },
                   sources = cmp.config.sources({
                     { name = "nvim_lsp" },
                     { name = "luasnip" },
                   }, {
                     { name = "buffer" },
                   }),
                 })
                 '';
      }
    ];

    extraPackages = with pkgs; [
      texliveFull
      lua53Packages.lua-lsp
      #llvmPackages_17.clang-unwrapped
      llvmPackages_21.libcxx
      llvmPackages_21.libcxxStdenv
      llvmPackages_21.libcxxClang
      clang-tools
      stylua
      proselint
      texlab
      tree-sitter
      nodejs
      fd
    ];
  };
}
