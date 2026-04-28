{ pkgs, ...}:
{
	imports = [
		./keybinds-nvf.nix
	];

  programs.nvf = {
    enable = true;

    settings = {
      vim = {
        viAlias = false;
        vimAlias = true;

				hideSearchHighlight = true;

				opts = {
					expandtab = false;
					smarttab = true;

					shiftwidth = 2;
					softtabstop = 2;
					tabstop = 2;

					breakindentopt = "shift:2,min:40,sbr";
					showbreak = "=>";
					mouse = "";

					syntax = "enable";

					scrolloff = 5;
					splitright = true;
					switchbuf = "useopen,usetab,newtab";
					
					foldmethod = "manual";
				};

				clipboard = {
					enable = true;
					registers = "unnamedplus";
					providers = {
						xclip.enable = true;
					};
				};

				undoFile.enable = true;

        spellcheck = {
          enable = true;
          programmingWordlist.enable = false;
					ignoredFiletypes = [
						"c"
						"cpp"
						"toggleterm"
						"python"
						"meson"
					];
        };

        lsp = {
          enable = true;

          formatOnSave = false;
          lspkind.enable = true;
          trouble.enable = true;
          lightbulb.enable = true;
          lspsaga = {
						enable = true;
						setupOpts = {
							finder = {
								keys = {
									split = "U";
									vsplit = "u";
								};
							};
							callhierarchy = {
								keys = {
									edit = "a";
									split = "U";
									vsplit = "u";
									toggle_or_req = "k";
								};
							};
							outline = {
								close_after_jump = true;
								layout = "float";
								keys = {
									jump = "<CR>";
								};
							};
						};
					};
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
					rainbow-delimiters.enable = true;

          highlight-undo.enable = true;
          blink-indent.enable = true;
          indent-blankline.enable = false;
        };

        statusline = {
          lualine = {
            enable = true;
						activeSection = {
							a = [ '' { "mode", icons_enabled = true, separator = { left = '▎', right = "" }, } ''
										'' { "", draw_empty = true, separator = { left = "", right = "" } } ''
									];
							b = [ '' { "diff", colored = true, 
													diff_color = { -- Same color values as the general color option can be used here.
														added = 'DiffAdd', -- Changes the diff's added color 
														modified = 'DiffChange', -- Changes the diff's modified color
														removed = 'DiffDelete',}, -- Changes the diff's removed color you 
													symbols = {added = '+', modified = ' ~', removed = ' -'}, -- Changes the diff symbols
													separator = {right = ""} } '' 
									];
							c = [ '' { "filetype", colored = true, icon_only = true, icon = { align = 'right' } } ''
										'' { "filename", symbols = {modified = '[+]', readonly = '[/]'}, separator = {right = ""} } ''
										'' { "", draw_empty = true, separator = { left = "", right = "" } } ''
									];
							x = [ '' { -- Lsp server name
												 function() local buf_ft = vim.bo.filetype local excluded_buf_ft = { toggleterm = true, NvimTree = true, ["neo-tree"] = true, TelescopePrompt = true } if excluded_buf_ft[buf_ft] then return "" end local bufnr = vim.api.nvim_get_current_buf() local clients = vim.lsp.get_clients({ bufnr = bufnr }) if vim.tbl_isempty(clients) then return "No Active LSP" end local active_clients = {} for _, client in ipairs(clients) do table.insert(active_clients, client.name) end return table.concat(active_clients, ", ") end, icon = '語', separator = {left = ""}, } '' '' { "diagnostics", sources = {'nvim_lsp', 'nvim_diagnostic', 'nvim_diagnostic', 'vim_lsp', 'coc'}, symbols = {error = '󰅙 ', warn = ' ', info = ' ', hint = '󰌵 '}, colored = true, update_in_insert = false, always_visible = false, diagnostics_color = { color_error = { fg = 'red' }, color_warn = { fg = 'yellow' }, color_info = { fg = 'cyan' }, }, 
												} '' ];
							y = [ '' { "", draw_empty = true, separator = { left = "", right = "" } } ''
										'' { 'searchcount', maxcount = 999, timeout = 120, separator = {left = ""} } ''
										'' { "branch", icon = ' •', separator = {left = ""} } ''
									];
							z = [ '' { "", draw_empty = true, separator = { left = "", right = "" } } ''
										'' { "progress", separator = {left = ""} } ''
										'' {"location"} ''
										'' { "fileformat", color = {fg='#282828'}, symbols = { unix = '' } } ''
									];
						};
            theme = "gruvbox";
          };
        };

				highlight = {
					"DiffAdd" = {
						bg = "#504945";
						fg = "#B8BB26";
					};
					"DiffChange" = {
						bg = "#504945";
						fg = "#FABD2F";
					};
					"DiffDelete" = {
						bg = "#504945";
						fg = "#FB4934";
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
          blink-cmp.enable = true;
        };

        filetree = {
          neo-tree.enable = false;
        };

				lazy.plugins = with pkgs.vimPlugins; {
					"oil-git.nvim" = {
						package = oil-git-nvim;
						lazy = false;
					};
				};

				extraPlugins = with pkgs.vimPlugins; {
					nvim-lastplace = {
						package = nvim-lastplace;
						setup = "require('nvim-lastplace').setup({})";
					};
					vimtex = {
						package = vimtex;
						setup = ''vim.g.vimtex_view_method = "zathura"
                      vim.g.vimtex_quickfix_mode = 0
                      vim.g.vimtex_matchparan_enabled = 0'';
					};
					omnisharp-extended-lsp-nvim = {
						package = omnisharp-extended-lsp-nvim;
					};
				};

				mini = {
					files = {
						enable = true;
						setupOpts = {
							mappings = {
								go_in				= "o";
								go_in_plus	= "O";
								go_out			= "n";
								go_out_plus = "N";
								synchronize = "W";
								close				= "<Esc>";
							};
							windows = {
								preview = true;
							};
							};
					};
				};

        tabline = {
          nvimBufferline = {
						enable = true;
						setupOpts = {
							options = {
								show_close_icon = false;
								show_buffer_close_icons = false;
								enforce_regular_tabs = false;
								separator_style = "thin";
								indicator.style = "none";
								modified_icon = "";
								numbers = "none";
								sort_by = "insert_at_end";
								diagnostics = false;
								style_preset = "no_italic";
								offsets = [];
							};
						};
					};
        };

        treesitter = {
          context.enable = false;
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
          nvim-notify = {
						enable = true;
						setupOpts = {
							background_colour = "#000000";
						};
					};
        };

        projects = {
          project-nvim.enable = true;
        };

        utility = {
          ccc.enable = true;
          vim-wakatime.enable = false;
          diffview-nvim.enable = true;
          yanky-nvim = {
            enable = true;
            setupOpts.ring.storage = "memory";
          };
					oil-nvim = {
						enable = true;
						gitStatus.enable = false;
						setupOpts = {
							use_default_keymaps = false;
							keymaps = {
								"<Space>tt" = "actions.close";
								"<CR>" = "actions.select";
							};
							view_options = {
								show_hidden = true;
							};
							float = {
								win_options = {
									winblend = 0;
								};
							};
						};
					};
          qmk-nvim.enable = false; # requires hardware specific options
          icon-picker.enable = true;
          surround.enable = true;
          leetcode-nvim.enable = false;
          multicursors.enable = true;
          smart-splits.enable = false;
          undotree.enable = true;
          nvim-biscuits.enable = false; # TODO want but broken
          grug-far-nvim.enable = true;

          motion = {
            hop.enable = false;
            leap.enable = false;
            # precognition.enable = true;
          };

          images = {
            image-nvim.enable = false;
            img-clip.enable = true;
          };
        };

        notes = {
          neorg.enable = true;
          orgmode.enable = false;
          mind-nvim.enable = false;
          todo-comments.enable = false;
					obsidian = {
						enable = true;
						setupOpts = {
							workspaces = [
								{
									name = "Knowledge";
									path = "~/Documents/obsidian/Knowledge";
								}
							];
							legacy_commands = false;
							ui = {
								enable = false;
							};
						};
					};
        };

        ui = {
          borders = {
						enable = true;
						globalStyle = "double";
					};
          noice.enable = true;
          colorizer.enable = true;
          modes-nvim.enable = true;
          illuminate.enable = true;
          breadcrumbs = {
            enable = false;
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
          nvim-session-manager.enable = false;
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
