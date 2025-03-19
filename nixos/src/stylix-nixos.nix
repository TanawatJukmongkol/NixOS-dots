
{
  pkgs,
  ...
} : {
  stylix.targets.grub.useImage = true;
  environment.sessionVariables = {
    QT_QPA_PLATFORMTHEME="qt5ct";
  };
}
