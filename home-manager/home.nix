# This is your home-manager configuration file
# Use this to configure your home environment (it replaces ~/.config/nixpkgs/home.nix)
{
	# inputs,
	outputs,
	# lib,
	# config,
	pkgs,
	...
}: {
	# You can import other home-manager modules here
	imports = [
		# If you want to use modules your own flake exports (from modules/home-manager):
		# outputs.homeManagerModules.example

		# Or modules exported from other flakes (such as nix-colors):
		# inputs.nix-colors.homeManagerModules.default

		# You can also split up your configuration and import pieces of it here:
		# ./nvim.nix
		./src/stylix.nix
		./src/stylix-home.nix
		./src/hyprland.nix
		./src/programs.nix
		./src/systemd.nix
		./src/environment.nix
	];

	nixpkgs = {
		# You can add overlays here
		overlays = [
			# Add overlays your own flake exports (from overlays and pkgs dir):
			outputs.overlays.additions
			outputs.overlays.modifications
			outputs.overlays.unstable-packages

			# You can also add overlays exported from other flakes:
			# neovim-nightly-overlay.overlays.default

			# Or define it inline, for example:
			# (final: prev: {
			#		hi = final.hello.overrideAttrs (oldAttrs: {
			#			patches = [ ./change-hello-to-hi.patch ];
			#		});
			# })
		];
		# Configure your nixpkgs instance
		config = {
			# Disable if you don't want unfree packages
			allowUnfree = true;
		};
	};

	# TODO: Set your username
	home = {
		username = "airgeddon1337";
		homeDirectory = "/home/airgeddon1337";
	};

	# Add stuff for your user as you see fit:

	fonts.fontconfig.enable = true;

	home.packages = with pkgs; [
		# Util
		appimage-run
		nvtopPackages.full
		cava
		# fastfetch
		waybar
		rofi-wayland
		rofi-bluetooth
		hyprpaper
		btop
		# hyprnome ???
		hyprpicker
		hyprshot
		wleave
		wl-clipboard
		cliphist
		# File management
		dolphin
		ark
		yazi
		# Editors
		# vscodium
		# Media
		mpv
		obs-studio
		miru
		yt-dlp
		subtitleeditor
		# Internet / Social media
		firefox
		chromium
		vesktop # discord, but doesn't suck
		irssi-v123
		wireshark-qt
		# VM
		virt-manager
		# Games
		osu-lazer-bin
		# Misc.
		obsidian
		glava
		# Fonts
		(nerdfonts.override {
			fonts = [ "Hack" "FiraCode" ];
		})
		tlwg
		noto-fonts-cjk
		noto-fonts-emoji
	];

	gtk = {
		enable = true;
		iconTheme = {
			name = "Flat-Remix-Cyan-Dark";
			package = pkgs.flat-remix-icon-theme;
		};
	};

	qt = {
		enable = true;
		platformTheme.name = "qtct";
		style.name = "kvantum";
	};

	xdg.configFile."Kvantum/kvantum.kvconfig".source = (pkgs.formats.ini {}).generate "kvantum.kvconfig" {
		General.theme = "Default";
	};

	xdg.configFile."Kvantum/Default".source = (pkgs.formats.ini {}).generate "Default.kvconfig" {
		"@General" = {
			translucent_windows = true;
		};
		Hacks = {
			transparent_dolphin_view = true;
			transparent_ktitle_label = true;
		};
	};

	xdg.configFile."qt5ct/qt5ct.conf".source = (pkgs.formats.ini {}).generate "kvantum.kvconfig" {
		Appearance.icon_theme = "Flat-Remix-Cyan-Dark";
	};

	# https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
	home.stateVersion = "24.05";
}
