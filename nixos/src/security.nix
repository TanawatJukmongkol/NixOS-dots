{
	pkgs,
	...
} : {
  security.polkit = {
    enable = true;
  };
  security.rtkit.enable = true;
  security.pam.services.hyprlock = {
    enable = true;
  };
  security.pam.loginLimits = [
    {
      domain = "*";
      type = "-";
      item = "memlock";
      value = "8192000";
    }
    {
      domain = "*";
      type = "-";
      item = "rtprio";
      value = "95";
    }
  ];

}

