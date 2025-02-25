{
  lib,
  config,
  ...
} : {
  networking = {
    networkmanager = {
		enable = true;
		connectionConfig."connection.mdns" = 2;
		unmanaged = [ "interface-name:wlp*" ]
			++ lib.optional config.services.hostapd.enable "interface-name:wlan-ap0";
	};
    hostName = "nixos";
    domain = "com";
    firewall = {
      allowedTCPPorts = [ 22 53 67 80 443 ];
      allowedUDPPorts = [ 22 53 67 80 443 ];
      allowedTCPPortRanges = [
        { from = 1000; to = 65535; }
      ];
      allowedUDPPortRanges = [
        { from = 1000; to = 65535; }
      ];
    };
	interfaces = lib.optionalAttrs config.services.hostapd.enable {
		"wlan-ap0".ipv4.addresses = [{ address = "192.168.12.1"; prefixLength = 24; }];
	};
	wlanInterfaces = lib.optionalAttrs config.services.hostapd.enable {
      "wlan-station0" = { device = "wlo1";                            };
      "wlan-ap0"      = { device = "wlo1"; mac = "08:11:96:0e:08:0a"; };
    };
  };
}
