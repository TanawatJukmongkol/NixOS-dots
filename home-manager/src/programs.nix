{
	outputs,
	lib,
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
			font_family				FiraCode Nerd Font Mono Reg
			tab_bar_style			powerline
			tab_separator			angle
			tab_activity_symbol		"◉ "
			bell_on_tab				" 󰂚"
			tab_title_template		"{index} {title[title.rfind('/')+1:]}{bell_symbol}"
			enable_audio_bell		false
			background				#060908
			map ctrl+shift+0		change_font_size all 0
			map kitty_mod+t			new_tab_with_cwd
			map kitty_mod+n			new_os_window_with_cwd
			map kitty_mod+enter		new_window_with_cwd
		'';
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
			vim-airline {
				plugin = vim-airline-themes;
				config = ''
					let g:airline_powerline_fonts = 1
					let g:airline_theme = 'owo'
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
						ensure_installed = { "nil_ls", "clangd", "rust_analyzer" }
					}
					require("lspconfig").nil_ls.setup {}
					require("lspconfig").clangd.setup {}
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
			set			listchars+=space:⋅
			set			listchars+=tab:→\ 
			set			listchars+=eol:↴
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
  services.mako = {
    enable = true;
	extraConfig = ''
background-color=#282a36af
text-color=#f4f7fa
border-color=#282a36
progress-color=#00ffff3a
border-radius=5
margin=5, 20
width=375
height=175
layer=overlay

[urgency=low]
border-color=#879a9c
default-timeout=7000

[urgency=normal]
border-color=#b0cfd1
default-timeout=10000

[urgency=high]
border-color=#d1a8f0'';
  };
}
