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
  # services.desktopManager.plasma6 = {
  #   enable = true;
  #   enableQt5Integration = true;
  # };
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
  '';
  services.openssh = {
    enable = true;
    ports = [ 6969 ];
    settings = {
      PermitRootLogin = "no";
      # PasswordAuthentication = false;
    };
  };
  services.dnsmasq = lib.optionalAttrs config.services.hostapd.enable {
    enable = true;
	settings = {
      interface="wlan-ap0";
      bind-interfaces=true;
      dhcp-range = [ "192.168.12.10,192.168.12.254,24h" ];
	};
  };
  services.avahi = {
    enable = true;
    nssmdns4 = true;
    nssmdns6 = true;
    wideArea = false;
    domainName = "${config.networking.domain}";
    publish = {
      enable = true;
      addresses = true;
      workstation = true;
      domain = true;
    };
  };
  services.resolved = {
    enable = true;
    extraConfig = ''
      MulticastDNS=true
    '';
    domains = [
      "local"
      "com"
    ];
  };
  services.blueman.enable = true;
  services.dbus = {
    enable = true;
    packages = [ pkgs.libsForQt5.kpmcore ];
  };
  services.hostapd = {
    enable = false;
	radios = {
		wlan-ap0 = {
			networks.wlan-ap0 = {
				ssid = "Airgeddon1337_AP";
				authentication = {
					saePasswords = [{ password = "airgeddon1337"; }];
				};
			};
		};
	};
  };
  services.samba = {
    enable = true;
    securityType = "user";
    openFirewall = true;
  };
  services.haveged.enable = config.services.hostapd.enable;
}
