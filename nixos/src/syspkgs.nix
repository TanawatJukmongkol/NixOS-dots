{
	pkgs,
  config,
	...
} : {
	environment.systemPackages = with pkgs; [
		# cachix
		cachix
		# System utils
		tree
		gzip
		unzip
		brightnessctl
		pulseaudio
		bluez
		bluez-tools
		isoimagewriter
		waypipe
		pkg-config
		nix-direnv-flakes
		xorg.xhost
		glxinfo
		libva-utils
		envyctrl
		wineWow64Packages.waylandFull
		# driver
		xp-pen-g430-driver
		maschine-mikro-mk3-driver
		kdePackages.partitionmanager
		kdePackages.plasma-workspace
		kdePackages.plasma-workspace-wallpapers
		kdePackages.dolphin
		kdePackages.kio
		kdePackages.kdf
		kdePackages.kio-fuse
		kdePackages.kio-extras
		kdePackages.kio-admin
		kdePackages.qtwayland
		kdePackages.qtsvg
		kdePackages.kservice
		bluetuith
		via
		libdrm
		libcamera
		# Manuals
		man-pages
		man-pages-posix
		# Build tools
		gnumake
		cmake
		meson
		cargo
		# Debuggers
		valgrind
		gdb
		lldb
		cutter
		# Language servers
		clang
		clang-tools
		nixd
		nixfmt-rfc-style
		# Common packags
		git
		git-lfs
		# Programming Language
		python3
		pyenv
		nodejs
		# Default minimal text editor
		nano
		# Custom packages
		(sddm-theme.override {
			themeConfig.General = {
				background = "${config.stylix.image}";
				backgroundMode = "none";
			};
		})
		# Tor
		tor
		nyx
		torsocks
		
		# Torrent
		qbittorrent
	];
}
