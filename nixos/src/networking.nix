{
  ...
} : {
  networking = {
    networkmanager = {
      enable = true;
    };
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
	extraHosts = ''
		127.0.0.3	tsirirak.42.fr
		::1			tsirirak.42.fr
	'';
  };
}
