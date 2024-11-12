{
	pkgs,
  config,
	...
} : {
	environment.systemPackages = with pkgs; [
		# home manager + cachix
		home-manager
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
		partition-manager
		isoimagewriter
		waypipe
		# driver
		xp-pen-g430-driver
		maschine-mikro-mk3-driver
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
