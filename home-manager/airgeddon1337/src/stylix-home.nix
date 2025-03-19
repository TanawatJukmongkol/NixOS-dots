{
  pkgs,
  config,
  ...
} : {
  stylix.targets.kitty.variant256Colors = true;
  stylix.targets.nixvim.plugin = true;
  stylix.targets.neovim.enable = true;
  stylix.targets.mako.enable = false;
  stylix.targets.mangohud.enable = false;

  home.file = {
    ".config/qt5ct/colors/oomox-current.conf".source = config.lib.stylix.colors {
          template = builtins.readFile ./dotfiles/qt5ct/oomox-current.conf.mustache;
          extension = ".conf";
        };
    ".config/Trolltech.conf".source = config.lib.stylix.colors {
          template = builtins.readFile ./dotfiles/Trolltech.conf.mustache;
          extension = ".conf";
        };
    ".config/kdeglobals".source = config.lib.stylix.colors {
          template = builtins.readFile ./dotfiles/Trolltech.conf.mustache;
          extension = "";
        };
    ".config/qt5ct/qt5ct.conf".text = pkgs.lib.mkBefore (builtins.readFile ./dotfiles/qt5ct/qt5ct.conf);
  };
  home.packages = with pkgs; [
    libsForQt5.qt5ct
  ];

}
