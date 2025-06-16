{
  lib,
  pkgs,
  config,
  ...
} : {
  services.xserver = {
    enable = true;
	excludePackages = with pkgs; [
		xterm
	];
    videoDrivers = [
      "modesetting"
      "nvidia"
    ];
    xkb = {
      variant = "";
      layout = "us";
    };
    displayManager.defaultSession = "hyprland";
  };
  services.displayManager = {
    sddm = {
      enable = true;
      wayland.enable = true;
      # theme = "sddm_theme_qt5";
    };
    autoLogin = {
      enable = true;
      user = "airgeddon1337";
    };
  };
  services.desktopManager.plasma6 = {
    enable = true;
    enableQt5Integration = true;
  };
  services.logind.extraConfig = ''
    HandlePowerKey=ignore
    HandleLidSwitch=suspend-then-hibernate
    HandleLidSwitchExternalPower=hybrid-sleep
  '';
  # services.upower.enable = true;
  services.usbmuxd = {
    enable = true;
    package = pkgs.usbmuxd2;
  };
  services.thermald.enable = true;
  # services.auto-cpufreq.enable = true;
  #services.auto-cpufreq.settings = {
  #  battery = {
  #    governor = "powersave";
  #    turbo = "never";
  #  };
  #  charger = {
  #    governor = "powersave";
  #    turbo = "never";
  #  };
  #};
  # sound.enable = true;
  services.pipewire = {
    enable = true;
    wireplumber.enable = true;
    alsa.enable = true;
    pulse.enable = true;
    jack.enable = true;
  };
  services.udisks2.enable = true;
  services.gvfs.enable = true;
  services.fstrim.enable = true;
  services.udev.packages = with pkgs; [
    android-udev-rules
    maschine-mikro-mk3-driver
  ];
  services.udev.extraRules = ''
    KERNEL=="uinput", MODE="0660", GROUP="uinput", OPTIONS+="static_node=uinput"
    KERNEL=="i2c-[0-9]*", GROUP="i2c", MODE="0660"
    SUBSYSTEM=="usbmon", GROUP="wireshark", MODE="0640"
    ACTION=="add", SUBSYSTEM=="pci", ATTR{power/control}="auto"
  '';
  services.openssh = {
    enable = true;
    ports = [ 6969 ];
    settings = {
      PermitRootLogin = "no";
      # PasswordAuthentication = false;
    };
  };
  services.avahi = {
    enable = true;
    nssmdns4 = true;
    nssmdns6 = true;
    wideArea = false;
    publish = {
      enable = true;
      addresses = true;
      workstation = true;
      domain = true;
    };
  };
  services.blueman.enable = true;
  services.geoclue2.enable = true;
  services.dbus = {
    enable = true;
    packages = [ pkgs.libsForQt5.kpmcore ];
  };
  services.samba = {
    enable = true;
    securityType = "user";
    openFirewall = true;
  };
  services.printing.enable = true;
  services.hardware.openrgb.enable = true;
  services.ratbagd.enable = true;
  systemd.services.NetworkManager-wait-online.enable = false;
  systemd.services.disable-usb-wakeup = {
    description = "Disable USB wakeups (XHCI)";
    after = [ "sysinit.target" ];
    wantedBy = [ "multi-user.target" ];
    serviceConfig = {
      Type = "oneshot";
      ExecStart = "/bin/sh -c 'echo XHCI > /proc/acpi/wakeup'";
      RemainAfterExit = true;
    };
  };
  systemd.sleep.extraConfig = ''
    DefaultTimeoutStopSec=5s
  '';
}
