{
  ...
} : {
  networking = {
    networkmanager.enable = true;
    firewall = {
      allowedTCPPorts = [ 53 67 80 443 6969 1701 9001 4455 ];
      allowedUDPPorts = [ 53 67 80 443 6969 1701 9001 4455 ];
      allowedTCPPortRanges = [
        { from = 3000; to = 4007; }
        { from = 8000; to = 8010; }
      ];
    };
  };
}