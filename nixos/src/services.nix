{
  pkgs,
  ...
} : {
  services.xserver = {
    enable = true;
	excludePackages = with pkgs; [
		xterm
	];
    videoDrivers = [
      "i915.force_probe=4c8a"
      "nvidia"
    ];
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
  services.displayManager = {
	sddm = {
   		enable = true;
   		theme = "sddm_theme_qt5";
   		wayland.enable = true;
  	};
	autoLogin = {
		enable = true;
		user = "airgeddon1337";
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
    hostName = "42pong";
    domainName = "com";
    publish = {
      enable = true;
      addresses = true;
      workstation = true;
    };
  };
  services.dbus.packages = [ pkgs.libsForQt5.kpmcore ];
}
