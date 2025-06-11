{
	pkgs,
	...
}: {
  # Enable home-manager and git
	programs.home-manager.enable = true;
	programs.zsh = {
		enable = true;
		enableCompletion = true;
		shellAliases = {
			neofetch = "fastfetch";
		};
		oh-my-zsh = {
			enable = true;
			plugins = [ "git" "sudo" "docker" "kubectl" ];
			theme = "agnoster";
		};
	};
	programs.kitty = {
		enable = true;
		extraConfig = ''
			font_family					FiraCode Nerd Font Mono Reg
			tab_bar_style				powerline
			tab_separator				angle
			tab_activity_symbol			"◉ "
			bell_on_tab					" 󰂚"
			tab_title_template			"{index} {title[title.rfind('/')+1:]}{bell_symbol}"
			enable_audio_bell			false
			background					#060908
			background_opacity			0.65
			dynamic_background_opacity	yes
			map ctrl+shift+0			change_font_size all 0
			map kitty_mod+t				new_tab_with_cwd
			map kitty_mod+n				new_os_window_with_cwd
			map kitty_mod+enter			new_window_with_cwd
		'';
		package = pkgs.unstable.kitty;
	};
	programs.neovim =
	let
		toLua = str: "lua << EOF\n${str}\nEOF\n";
	in
	{
		enable = true;
		defaultEditor = true;
		viAlias = true;
		vimAlias = true;
		vimdiffAlias = true;
		plugins = with pkgs.vimPlugins; [
			transparent-nvim
			{
				plugin = telescope-nvim;
				config = toLua ''
					local builtin = require('telescope.builtin')
					require('telescope').setup{
						defaults = {
							-- Default configuration for telescope goes here:
							-- config_key = value,
							mappings = {
								i = {
									-- map actions.which_key to <C-h> (default: <C-/>)
									-- actions.which_key shows the mappings for your picker,
									-- e.g. git_{create, delete, ...}_branch for the git_branches picker
									["<C-h>"] = "which_key"
								}
							}
						},
						pickers = {},
						extensions = {}
					}
					vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
					vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
					vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
					vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })
				'';
			}
			vim-airline {
				plugin = vim-airline-themes;
				config = ''
					let g:airline_powerline_fonts = 1
					let g:airline_theme = 'base16'
				'';
			}
			{
				plugin = comment-nvim;
				config = toLua ''
					require("Comment").setup {}
				'';
			}
			nvim-lspconfig mason-nvim {
				plugin = mason-lspconfig-nvim;
				config = toLua ''
					require("mason").setup()
					require("mason-lspconfig").setup {
						ensure_installed = {
							"nil_ls",
							"clangd",
							"rust_analyzer"
						}
					}
					require("lspconfig").nil_ls.setup {
						cmd = {"/run/current-system/sw/bin/nixd";}
					}
					require("lspconfig").clangd.setup {
						cmd = {"/run/current-system/sw/bin/clangd"},
					}
					require("lspconfig").rust_analyzer.setup {}
				'';
			}
			cmp-nvim-lsp cmp-buffer cmp-path cmp-cmdline {
				plugin = nvim-cmp;
				config = toLua ''
					local cmp = require('cmp');
					cmp.setup {
						mapping = cmp.mapping.preset.insert({
							['<C-b>'] = cmp.mapping.scroll_docs(-4),
							['<C-f>'] = cmp.mapping.scroll_docs(4),
							['<C-Space>'] = cmp.mapping.complete(),
							['<C-e>'] = cmp.mapping.abort(),
							['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
						}),
						sources = {
							{ name = 'nvim_lsp' },
							{ name = 'buffer' },
							{ name = 'rust_analyzer' },
						}
					}
					cmp.setup.cmdline({ '/', '?' }, {
						mapping = cmp.mapping.preset.cmdline(),
							sources = {
								{ name = 'buffer' }
							}
						})
					cmp.setup.cmdline(':', {
						mapping = cmp.mapping.preset.cmdline(),
						sources = cmp.config.sources({
							{ name = 'path' }
						}, {
							{ name = 'cmdline' }
						}),
						matching = { disallow_symbol_nonprefix_matching = false }
					})
				'';
			}
			{
				plugin = (nvim-treesitter.withPlugins (p: [
					p.tree-sitter-nix
					p.tree-sitter-vim
					p.tree-sitter-bash
					p.tree-sitter-lua
					p.tree-sitter-python
					p.tree-sitter-json
					p.tree-sitter-c
					p.tree-sitter-rust
				]));
				config = toLua ''
					require('nvim-treesitter.configs').setup {
						ensure_installed = {},
						auto_install = false,
						highlight = { enable = true },
						indent = { enable = true },
					}
				'';
			}
			{
				plugin = lsp_signature-nvim;
				config = toLua ''
					local cfg = {}  -- add your config here
					require "lsp_signature".setup(cfg)
				'';
			}
			{
				plugin = vim-clang-format;
			}
		];
		extraConfig = ''
			" set		autoindent
			set			smartindent
			set			noexpandtab
			" set		expandtab
			set			tabstop=4
			set			shiftwidth=4
			set			backspace=indent,eol,start
			" syntax	on
			set			nu
			set			list
			" set			listchars+=space:⋅
			" set			listchars+=tab:→\ 
			" set			listchars+=eol:↴
			hi Pmenu		ctermfg=white ctermbg=black gui=NONE guifg=white guibg=black
			hi PmenuSel		ctermfg=white ctermbg=blue gui=bold guifg=white guibg=purple
		'';
	};
	programs.fastfetch = {
		enable = true;
		settings = {
			logo = {
				source = "~/.face";
				height = 12;
				padding = {
					left = 2;
					right = 2;
					top = 1;
				};
			};
			#display = {
				#size = {
				#  binaryPrefix = "si";
				#};
				# color = "blue";
				# separator = "  ";
			#};
			modules = [
				"break"
				"title"
				"separator"
				"os"
				"host"
				"kernel"
				"packages"
				"shell"
				"de"
				"wm"
				"wmtheme"
				"cpu"
				"gpu"
				"break"
				"colors"
				"break"
			];
		};
	};
	programs.mangohud = {
		enable = true;
		settings = {
			#control="mangohud";
			fsr_steam_sharpness=5;
			#nis_steam_sharpness=10;
			legacy_layout=0;
			horizontal=true;
			battery=true;
			gpu_stats=true;
			cpu_stats=true;
			cpu_power=true;
			gpu_power=true;
			ram=true;
			fps=true;
			frametime=0;
			hud_no_margin=true;
			table_columns=14;
			frame_timing=1;
		};
	};
	programs.vscode = {
		enable = true;
		mutableExtensionsDir = true;
		package = pkgs.unstable.vscodium;
		extensions = (with pkgs.nix-vscode-extensions; [
			vscode-marketplace.leonardssh.vscord
			# vscode-marketplace.ms-toolsai.jupyter
			open-vsx.llvm-vs-code-extensions.vscode-clangd
			open-vsx.medo64.render-crlf
			open-vsx.jeanp413.open-remote-ssh
			open-vsx.pinage404.nix-extension-pack
			open-vsx.tomoki1207.pdf
			open-vsx.ms-azuretools.vscode-docker
			open-vsx.ms-toolsai.jupyter-renderers
			open-vsx.ms-python.python
		]);
		userSettings = {
			"editor.renderWhitespace" = "all";
			"terminal.integrated.enablePersistentSessions" = false;
			"nix.enableLanguageServer" = true;
			"nix.serverPath" = "/run/current-system/sw/bin/nixd";
			"notebook.lineNumbers" = "on";
			"extensions.autoUpdate" = false;
		};
	};
}
