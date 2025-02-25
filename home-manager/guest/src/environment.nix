{
	pkgs,
	lib,
	...
} :
{
	home.sessionVariables = {
		EDITOR = "nvim";
		NIXPKGS_ALLOW_UNFREE = 1;
		XMODIFIERS = "@im=fcitx";
		GTK_IM_MODULE = "";
		QT_IM_MODULE = "";
		NIXOS_OZONE_WL = 1;
		LIBVA_DRIVER_NAME = "i965";
	};
}
