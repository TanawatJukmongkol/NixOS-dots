{
  pkgs,
  ...
} : {
  stylix = {
    enable = true;
    # image = "${assets/background/MoriCalliope.jpg}";
    # image = "${assets/background/halloween.png}";
    # image = "${assets/background/snow-miku.jpg}";
    image = "${assets/background/Alya.png}";
    #base16Scheme = "${pkgs.base16-schemes}/share/themes/nord.yaml";
    #base16Scheme = "${pkgs.base16-schemes}/share/themes/tokyo-night-dark.yaml";
    #base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-frappe.yaml";
    base16Scheme = "${pkgs.base16-schemes}/share/themes/rose-pine.yaml";
    iconTheme = {
      enable = true;
      light = "Flat-Remix-Cyan-Light";
      dark = "Flat-Remix-Cyan-Dark";
      package = pkgs.flat-remix-icon-theme;
    };
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
