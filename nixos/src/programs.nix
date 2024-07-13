{
  # inputs,
  pkgs,
  ...
} : {
  programs.hyprland = {
    enable = true;
    # package = inputs.hyprland.packages."${pkgs.system}".hyprland;
  };
  programs.nm-applet = {
    enable = true;
    indicator = true;
  };
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    ohMyZsh = {
      enable = true;
      plugins = [ "git" "sudo" "docker" "kubectl" ];
    };
  };
  programs.dconf.enable = true;
  programs.nix-ld = {
    enable = true;
    libraries = with pkgs; [
      xorg.libX11
      libGL
      libGLU
    ];
  };
}
