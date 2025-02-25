{
  pkgs,
  lib,
  ...
}:
{
  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";
  systemd.user.services.polkit-mate-authentication-agent-1 = {
    Unit = {
      Description = "Policy kit for superuser privilage authentication.";
    };
    Install = {
      WantedBy = [ "default.target" ];
    };
    Service = {
      Type = "simple";
      ExecStart = "${pkgs.mate.mate-polkit}/libexec/polkit-mate-authentication-agent-1";
      Restart = "on-failure";
      RestartSec = 1;
      TimeoutStopSec = 10;
    };
  };
}
