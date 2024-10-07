{
  pkgs,
  ...
} : {
  stylix = {
    enable = true;
    #image = "${../../assets/background/Alya.png}";
    image = "${../../assets/background/halloween.png}";
    #base16Scheme = "${pkgs.base16-schemes}/share/themes/nord.yaml";
    #base16Scheme = "${pkgs.base16-schemes}/share/themes/tokyo-night-dark.yaml";
    base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-frappe.yaml";
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
}
