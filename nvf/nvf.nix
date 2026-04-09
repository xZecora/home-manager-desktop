{_, ...}: {
  programs.nvf = {
    enable = true;

    settings = {
      vim = {
        viAlias = false;
        vimAlias = true;

				opts = {
					expandtab = false;
					smarttab = true;

					shiftwidth = 2;
					softtabstop = 2;
					tabstop = 2;

					breakindentopt = "shift:2,min:40,sbr";
					showbreak = "=>";
					mouse = "";

					hlsearch = true;

					syntax = "enable";

					clipboard = "unnamedplus";

					scrolloff = 5;
					splitright = true;
					switchbuf = "useopen,usetab,newtab";
				};

				undoFile.enable = true;

        spellcheck = {
          enable = true;
          programmingWordlist.enable = false;
        };

        lsp = {
          enable = true;

          formatOnSave = false;
          lspkind.enable = true;
          trouble.enable = true;
          lightbulb.enable = true;
          lspsaga.enable = true;
          otter-nvim.enable = true;
          harper-ls.enable = false;
        };

        debugger = {
          nvim-dap = {
            enable = false;
            ui.enable = false;
          };
        };

        languages = {
          enableFormat = true;
          enableTreesitter = true;
          enableExtraDiagnostics = true;

          nix.enable = true;
          markdown.enable = true;

          make.enable = true;

          bash.enable = true;

          clang = {
            enable = true;
            lsp.servers = ["clangd"];
          };
          tex.enable = true;
          python.enable = true;
          lua.enable = true;
          sql.enable = true;
          json.enable = true;

          ts.enable = true;
          csharp.enable = true;
        };

        visuals = {
          nvim-scrollbar.enable = true;
          nvim-web-devicons.enable = true;
          nvim-cursorline.enable = true;
          cinnamon-nvim.enable = false;
          fidget-nvim.enable = true;

          highlight-undo.enable = true;
          blink-indent.enable = true;
          indent-blankline.enable = false;
        };

        statusline = {
          lualine = {
            enable = true;
            theme = "gruvbox";
          };
        };

        theme = {
          enable = true;
          name = "gruvbox";
          style = "dark";
          transparent = true;
        };

        autopairs = {
          nvim-autopairs.enable = true;
        };

        autocomplete = {
          nvim-cmp.enable = false;
          blink-cmp.enable = true; #TODO want but broken
        };

        filetree = {
          neo-tree.enable = true;
        };

        tabline = {
          nvimBufferline.enable = true;
        };

        treesitter = {
          context.enable = true;
        };

        binds = {
          whichKey.enable = true;
          cheatsheet.enable = true;
        };

        telescope.enable = true;

        git = {
          enable = true;
          gitsigns.enable = true;
          gitsigns.codeActions.enable = false;
          neogit.enable = true;
        };

        minimap = {
          minimap-vim.enable = false;
          codewindow.enable = false; # TODO want but broken
        };

        dashboard = {
          dashboard-nvim.enable = false;
          alpha.enable = true;
        };

        notify = {
          nvim-notify.enable = true;
        };

        projects = {
          project-nvim.enable = true;
        };

        utility = {
          ccc.enable = false;
          vim-wakatime.enable = false;
          diffview-nvim.enable = true;
          yanky-nvim = {
            enable = true;
            setupOpts.ring.storage = "memory";
          };
          qmk-nvim.enable = false; # requires hardware specific options
          icon-picker.enable = true;
          surround.enable = true;
          leetcode-nvim.enable = true;
          multicursors.enable = true;
          smart-splits.enable = true;
          undotree.enable = true;
          nvim-biscuits.enable = false; # TODO want but broken
          grug-far-nvim.enable = true;

          motion = {
            hop.enable = true;
            leap.enable = true;
            # precognition.enable = true;
          };

          images = {
            image-nvim.enable = false;
            img-clip.enable = true;
          };
        };

        notes = {
          neorg.enable = false;
          orgmode.enable = false;
          mind-nvim.enable = true;
          todo-comments.enable = true;
        };

        ui = {
          borders.enable = true;
          noice.enable = true;
          colorizer.enable = true;
          modes-nvim.enable = true;
          illuminate.enable = true;
          breadcrumbs = {
            enable = true;
            navbuddy.enable = true;
          };
          smartcolumn.enable = false;
          fastaction.enable = true;
        };

        assistant = {
          chatgpt.enable = false;
          copilot.enable = false;
          codecompanion-nvim.enable = false;
          avante-nvim.enable = false;
        };

        session = {
          nvim-session-manager.enable = true;
        };

        gestures = {
          gesture-nvim.enable = false;
        };

        presence = {
          neocord.enable = true;
        };
      };
    };
  };
}
