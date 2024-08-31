{
	pkgs,
	...
} : {
	environment.systemPackages = with pkgs; [
		# home manager
		home-manager
		# System utils
		tree
		gzip
		unzip
		brightnessctl
		pulseaudio
		direnv
		bluez
		bluez-tools
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
		nixd
		# Common packags
		git
		python3
		# Default minimal text editor
		nano
		# Custom packages
		(sddm-theme.override {
			themeConfig.General = {
				background = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
				backgroundMode = "none";
			};
		})
	];
}
