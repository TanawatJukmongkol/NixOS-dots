
{
  pkgs,
  ...
} : {
  #stylix.targets.grub.enable = false;
  stylix.targets.grub.useImage = true;
  stylix.targets.plymouth.enable = false;
  # environment.sessionVariables = {
  #   QT_QPA_PLATFORMTHEME="qt5ct";
  # };
}
