# This is your home-manager configuration file
# Use this to configure your home environment (it replaces ~/.config/nixpkgs/home.nix)
{
	inputs,
	outputs,
	# lib,
	config,
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

	fonts ={
		fontconfig = {
			enable = true;
			# defaultFonts = {
			# 	emoji = [ "Noto Fonts Color-Emoji" ];
			# };
		};
	};

	home.packages = with pkgs; [
		# Util
		appimage-run
		nvtopPackages.full
		powertop
		powerstat
		usbutils
		cava
		nwg-displays
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
		# office
		libreoffice
		# File management
		# dolphin
		kdePackages.ark
		yazi
		# Editors
		#vscode-fhs
		# android-studio
		# Media
		mpv
		miru
		yt-dlp
		subtitleeditor
		krita
		gimp3
		# Internet / Social media
		firefox
		chromium
		(inputs.zen-browser.packages."x86_64-linux".default)
		teams-for-linux
		vesktop
		tor-browser
		# (discord.override {
		# 	withVencord = true;
		# })

		irssi-v123
		wireshark-qt
		# teams-for-linux
		slack
		# VM
		virt-manager
		# Games
		osu-lazer-bin-latest
		prismlauncher-quacked
		gamescope
		godot_4
		(lutris.override {
			extraLibraries =  pkgs: [
				# List library dependencies
				speexdsp
				libgudev
				libvdpau
			];
		})
		# Misc.
		obsidian
		glava
		# Fonts
		tlwg
		noto-fonts-cjk-sans
		noto-fonts-emoji
		nerd-fonts.hack
		nerd-fonts.fira-code
		# programming
		poetry
		unstable.norminette
		# dart
		flutter
	];

	home.file = {
		".config/waybar".source = config.lib.file.mkOutOfStoreSymlink ../../assets/config/waybar;
		".config/rofi".source = config.lib.file.mkOutOfStoreSymlink ../../assets/config/rofi;
	};

	# https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
	home.stateVersion = "25.05";
}
