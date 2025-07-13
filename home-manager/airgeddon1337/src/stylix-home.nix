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
  stylix.targets.vscode.profileNames = [
    "default"
    "clang"
    "clang-42"
    "python"
  ];

  # home.packages = with pkgs; [
  #   libsForQt5.qt5ct
  # ];

}
