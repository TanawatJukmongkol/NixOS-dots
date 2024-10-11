
{
  pkgs,
  ...
} : {
  stylix.targets.grub.useImage = true;

  qt = {
    enable = true;
    platformTheme = "qt5ct";
    style = "kvantum";
  };
}
