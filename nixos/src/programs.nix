{
  pkgs,
  ...
} : {
  programs.auto-cpufreq = {
	enable = false;
	# enable = true;
    settings = {
      charger = {
        governor = "performance";
        turbo = "auto";
      };
      battery = {
        governor = "powersave";
        turbo = "auto";
      };
    };
  };
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
    # package = pkgs.unstable.hyprland;
    # portalPackage = pkgs.unstable.xdg-desktop-portal-hyprland;
    package = pkgs.hyprland-flake.hyprland;
    portalPackage = pkgs.hyprland-flake.xdg-desktop-portal-hyprland;
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
  programs.obs-studio = {
    enable = true;
    enableVirtualCamera = true;

    # optional Nvidia hardware acceleration
    package = (
      pkgs.obs-studio.override {
        cudaSupport = true;
      }
    );

    plugins = with pkgs.obs-studio-plugins; [
      wlrobs
      obs-backgroundremoval
      obs-pipewire-audio-capture
      obs-gstreamer
      obs-vkcapture
    ];
  };
  programs.steam = {
    enable = true;
    extraCompatPackages = with pkgs; [
      proton-ge-bin
    ];
  };
  programs.adb.enable = true;
  programs.partition-manager.enable = true;
  programs.wireshark.enable = true;
  programs.git = {
    enable = true;
    lfs.enable = true;
  };
  programs.alvr = {
    enable = true;
    openFirewall = true;
  };
}
