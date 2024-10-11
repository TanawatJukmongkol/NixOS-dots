{
  pkgs,
  ...
} : {
  programs.hyprland = {
    enable = true;
    package = pkgs.hyprland-flake;
  };
  programs.nm-applet = {
    enable = true;
    indicator = true;
  };
  programs.zsh.enable = true;
  programs.dconf.enable = true;
  programs.nix-ld = {
    enable = true;
    libraries = with pkgs; [
      xorg.libX11
      libGL
      libGLU
    ];
  };
  programs.steam = {
    enable = true;
    extraCompatPackages = with pkgs; [
      proton-ge-bin
    ];
  };
  programs.partition-manager.enable = true;
  programs.wireshark.enable = true;
}
