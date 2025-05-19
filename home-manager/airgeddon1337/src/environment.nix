{
	lib,
	...
} :
{
	home.sessionVariables = {
		EDITOR = "nvim";
		NIXPKGS_ALLOW_UNFREE = 1;
		XMODIFIERS = "@im=fcitx";
		GTK_IM_MODULE = "";
		# QT_IM_MODULE = null;
		# AQ_DRM_DEVICES = "/dev/dri/card1:/dev/dri/card0";
		# KWIN_DRM_DEVICES = "/dev/dri/card1:/dev/dri/card0";
		LIBVA_DRIVER_NAME = "iHD";
		KWIN_DRM_USE_MODIFIERS = "0";
	};
}
