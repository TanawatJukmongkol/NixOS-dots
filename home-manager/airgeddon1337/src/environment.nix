{
	lib,
	...
} :
{
	home.sessionVariables = {
		EDITOR = "nvim";
		GTK_IM_MODULE="wayland;fcitx;ibus";
		QT_IM_MODULE="wayland;fcitx;ibus";
		XMODIFIERS="@im=fcitx";
	};
}
