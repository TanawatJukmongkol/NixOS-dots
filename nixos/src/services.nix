{
  pkgs,
  ...
} : {
  services.xserver = {
    enable = true;
    videoDrivers = [ "intel" "nvidia" ];
    # displayManager.lightdm = {
    #   enable = true;
    #   greeters.slick.enable = true;
    # };
    # displayManager.gdm = {
    #   enable = true;
    #   wayland = true;
    # };
    xkb = {
      variant = "";
      layout = "us";
    };
  };
  services.displayManager.sddm = {
    enable = true;
    wayland = {
      enable = true;
      # compositorCommand = "Hyprland";
    };
  };
  services.logind.extraConfig = ''
    HandlePowerKey=ignore
    HandleLidSwitch=suspend-then-hibernate
    HandleLidSwitchExternalPower=hybrid-sleep
  '';
  services.upower.enable = true;
  services.usbmuxd = {
    enable = true;
    package = pkgs.usbmuxd2;
  };
  services.thermald.enable = true;
  services.auto-cpufreq.enable = true;
  services.auto-cpufreq.settings = {
    battery = {
      governor = "powersave";
      turbo = "never";
    };
    charger = {
      governor = "powersave";
      turbo = "never";
    };
  };
  services.pipewire = {
    enable = true;
    wireplumber.enable = true;
    alsa.enable = true;
    pulse.enable = true;
  };
  services.jack = {
    jackd.enable = true;
    alsa.enable = false;
    loopback = {
      enable = true;
    };
  };
  services.udisks2.enable = true;
  services.gvfs.enable = true;
  services.udev.packages = [ pkgs.android-udev-rules ];
  services.udev.extraRules = ''
    KERNEL=="uinput", MODE="0660", GROUP="uinput", OPTIONS+="static_node=uinput"
  '';
  services.openssh = {
    enable = true;
    ports = [ 6969 ];
    settings = {
      PermitRootLogin = "no";
      # PasswordAuthentication = false;
    };
  };
}
