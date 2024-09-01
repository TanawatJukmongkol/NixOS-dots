
{
  pkgs,
  ...
} : {
  stylix = {
    enable = true;
    # image = "${/home/airgeddon1337/Pictures/Background/Tranquil.png}";
    # image = "${/home/airgeddon1337/Pictures/Background/nixos.png}";
    image = "${/home/airgeddon1337/Pictures/Background/tokyo_night.jpg}";
    base16Scheme = "${pkgs.base16-schemes}/share/themes/nord.yaml";
    #base16Scheme = "${pkgs.base16-schemes}/share/themes/tokyo-night-dark.yaml";
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
