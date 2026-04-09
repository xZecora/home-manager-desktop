{ pkgs, ... }:

{
  imports = [
    ./config-nvim.nix
    ./keybinds-nvim.nix
  ];

  home = {
    packages = with pkgs; [
      neovide
    ];
    sessionVariables = {
      EDITOR = "nvim";
    };
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

    withPython3 = true;
    withRuby = true;

    plugins = with pkgs.vimPlugins; [
      nvim-web-devicons
      vim-nix
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
      vim-illuminate
      vim-gitgutter
      targets-vim
      # Tim Pope plugins
      vim-fugitive
      vim-commentary
      vim-surround 
      # End Tim Pope plugins
      (nvim-treesitter.withPlugins (p: [
        p.tree-sitter-nix
        p.tree-sitter-vim
        p.tree-sitter-vimdoc
        p.tree-sitter-bash
        p.tree-sitter-lua
        p.tree-sitter-odin
        p.tree-sitter-regex
        p.tree-sitter-latex
        p.tree-sitter-markdown-inline
        p.tree-sitter-markdown
        p.tree-sitter-html
        p.tree-sitter-yaml
        p.tree-sitter-c
        p.tree-sitter-cpp
        p.tree-sitter-python
        p.tree-sitter-angular
      ]))
      {
        plugin = gitsigns-nvim;
        config = toLua "require('gitsigns').setup({ signcolumn = false, })";
      }
      barbar-nvim
      {
        plugin = rainbow-delimiters-nvim;
        config = toLua ''
local rainbow_delimiters = require 'rainbow-delimiters'

---@type rainbow_delimiters.config
require('rainbow-delimiters.setup').setup {
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
      # {
      #   plugin = nvim-notify;
      #   config = toLua ''vim.notify = require('notify').setup({ background_colour = "#000000", })'';
      # }
      {
      plugin = obsidian-nvim;
      config = toLua ''
                require("obsidian").setup({
	                workspaces = {
		                {
			                name = "Knowledge",
			                path = "~/Documents/obsidian/Knowledge",
		                },
	                },
                  legacy_commands = false,
                  ui = {
                    enable = false,
                  }
                })'';
      }
      {
        plugin = render-markdown-nvim;
        config = toLua ''
          require('render-markdown').setup({})
          vim.cmd("let g:markdown_fenced_languages = ['c', 'bash', 'python', 'rust', 'cpp']")
        '';
      }
      {
        plugin = ultimate-autopair-nvim;
        config = toLua "require('ultimate-autopair').setup()";
      }
      {
        plugin = lualine-nvim;
        config = toLua "require('lualine').setup({ options = {theme = 'auto', },})";
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
  -- vim.cmd('hi NvimTreeNormal guibg=NONE')
end

-- pass to setup along with your other options
require("nvim-tree").setup({
  on_attach = my_on_attach,
})'';
      }
      # {
        # plugin = everforest;
        # config = ''
          # let g:everforest_background = 'soft'
          # let g:everforest_enable_italic = 1
          # colorscheme everforest
        # '';
      # }
      # {
        # plugin = onedark-nvim;
        # config = "colorscheme onedark";
      # }
      # {
        # plugin = dracula-nvim;
        # config = "colorscheme dracula";
      # }
      {
        plugin = srcery-vim;
         config = ''
          let g:srcery_bg=['none', 'none']
          "colorscheme srcery
         '';
      }
      {
        plugin = gruvbox-nvim;
        config = ''
          if !(exists('g:neovide'))
          lua << EOF
            require("gruvbox").setup({
              inverse = false,
              transparent_mode = true,
            })
          EOF
          else 
          lua << EOF
            require("gruvbox").setup({
              inverse = false,
            })
          EOF
          endif

          colorscheme gruvbox
          '';
      }
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
      oil-git-nvim
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
        plugin = nvim-lastplace;
        config = toLua "require('nvim-lastplace').setup();";
      }
      {
        plugin = nvim-lspconfig;
        #config = toLua ''local lspconfig = require('lspconfig')
        config = toLua ''vim.lsp.enable('lua_ls')
                         vim.lsp.config('ccls', {
                           init_options = {
                           compilationDatabaseDirectory = "build";
                           };
                         })
                         vim.lsp.enable('ccls')
                         vim.lsp.enable('basedpyright')
                         vim.lsp.enable('omnisharp')
                         vim.lsp.enable('bashls')
                         vim.lsp.enable('nil_ls')
                         vim.lsp.enable('zls')
                         vim.lsp.enable('texlab')
                         vim.lsp.enable('angularls')
                         vim.cmd('hi link @lsp.typemod.variable.namespaceScope.c GruvboxAqua')
                         vim.cmd('hi link @lsp.type.field.c GruvboxBlue')'';
      }
      {
        plugin = none-ls-nvim;
        config = toLua ''local null_ls = require('null-ls')
                         null_ls.setup({
                           sources = {
                             null_ls.builtins.formatting.stylua,
                             null_ls.builtins.diagnostics.write_good,
                             --null_ls.builtins.code_actions.proselint,
                             --null_ls.builtins.diagnostics.proselint,
                             --null_ls.builtins.completion.spell,
                             -- Nix
                             --null_ls.builtins.code-actions.statix,
                             null_ls.builtins.diagnostics.statix,
                             null_ls.builtins.formatting.nixfmt,
                             -- Markdown
                             --null_ls.builtins.code-actions.textlint,
                             --null_ls.builtins.diagnostics.textlint,
                             --null_ls.builtins.formatting.textlint,

                             --null_ls.builtins.hover.dictionary,
                             null_ls.builtins.completion.tags,
                           },
                         })'';
      }
      {
        plugin = trouble-nvim;
        config = toLua "require('trouble').setup({
                          keys = {
                            o = false,
                            i = false,
                          }
                        })";
      }
      {
        plugin = luasnip;
        config = toLua ''require('luasnip.loaders.from_vscode').lazy_load()'';
      }
      {
        plugin = alpha-nvim;
        config = toLua ''require'alpha'.setup(require'alpha.themes.dashboard'.config)'';
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
                   ["<A-Tab>"] = cmp.mapping(function(fallback)
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
                     --{ name = "luasnip" },
                     { name = "null_ls" },
                     { name = "path" },
                     --{ name = "cmdline" },
                   }, {
                     { name = "buffer" },
                   }),
                 })
                 '';
      }
      {
        plugin = nvim-colorizer-lua;
        config = toLua "require('colorizer').setup()";
      }
      firenvim
      {
        plugin = noice-nvim;
        # config = toLua "if vim.g.started_by_firenvim == false then require('noice').setup() end";
        config = ''
if !exists('g:started_by_firenvim')
lua << EOF 
  require('noice').setup()
EOF
endif
'';
      }
      restore-view-vim
      # omnisharp-extended-lsp-nvim
      roslyn-nvim
    ];

    extraLuaPackages = ps: [ ps.jsregexp ];

    extraPackages = with pkgs; [
      texliveFull
      lua53Packages.lua-lsp
      #llvmPackages_17.clang-unwrapped
      llvmPackages_21.libcxx
      llvmPackages_21.libcxxStdenv
      llvmPackages_21.libcxxClang
      #clang-tools
      ccls
      stylua
      #proselint
      write-good
      texlab
      tree-sitter
      nodejs
      fd
      git
      bash-language-server
      lua-language-server
      nil
      pstree
      statix
      nixfmt
      textlint
      curl
      obsidian
      python314Packages.pylatexenc
      zls
      tree-sitter
      # omnisharp-roslyn
      roslyn
      roslyn-ls
      dotnetCorePackages.sdk_10_0-bin
      angular-language-server
      basedpyright
    ];
  };
}
