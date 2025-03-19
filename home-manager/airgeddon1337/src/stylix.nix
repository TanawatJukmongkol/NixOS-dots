{
  pkgs,
  ...
} : {
  stylix = {
    enable = true;
	#image = "${assets/background/MoriCalliope.jpg}";
	#image = "${assets/background/halloween.png}";
	#image = "${assets/background/snow-miku.jpg}";
	#image = "${assets/background/Alya.png}";
	#image = "${assets/background/anime-girl-with-terminal.jpg}";
	#image = "${assets/background/cyberpunk.jpg}";
	image = "${assets/background/hutao1.jpg}";
	#base16Scheme = "${pkgs.base16-schemes}/share/themes/nord.yaml";
	#base16Scheme = "${pkgs.base16-schemes}/share/themes/tokyo-night-dark.yaml";
	#base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-frappe.yaml";
	base16Scheme = "${pkgs.base16-schemes}/share/themes/rose-pine.yaml";
	#base16Scheme = "${pkgs.base16-schemes}/share/themes/twilight.yaml";
	cursor = {
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Ice";
    };
    polarity = "dark";
    opacity = {
      applications = 0.0;
      desktop = 0.0;
      terminal = 0.79;
    };
    fonts = {
      sizes = {
        terminal = 14;
      };
    };
  };

  qt = {
    enable = true;
  };

}
