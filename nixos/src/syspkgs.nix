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
		direnv
		bluez
		bluez-tools
		isoimagewriter
		waypipe
		pkg-config
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
		# Language servers
		clang
		clang-tools
		nixd
		# Common packags
		git
		# Programming Language
		python3
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
	];
}
