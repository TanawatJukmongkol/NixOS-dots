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
	programs.neovim = {
		enable = true;
		defaultEditor = true;
		viAlias = true;
		vimAlias = true;
		vimdiffAlias = true;
		plugins = with pkgs.vimPlugins; [
			transparent-nvim
			vim-airline
			vim-airline-themes
			nvim-treesitter
		];
		extraConfig = ''
			" set					autoindent
			set						smartindent
			set						noexpandtab
			" set					expandtab
			set						tabstop=4
			set						shiftwidth=4
			set						backspace=indent,eol,start
			syntax					on
			set						nu
			set						list
			set						listchars+=space:⋅
			set						listchars+=tab:→\ 
			set						listchars+=eol:↴

			hi Pmenu		ctermfg=white ctermbg=black gui=NONE guifg=white guibg=black
			hi PmenuSel		ctermfg=white ctermbg=blue gui=bold guifg=white guibg=purple

			let g:airline_powerline_fonts = 1
			let g:airline_theme='owo'
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
}
