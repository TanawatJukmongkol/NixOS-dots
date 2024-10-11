# This file defines overlays
{
  inputs,
  # pkgs,
  ...
} : {
  # This one brings our custom packages from the 'pkgs' directory
  additions = final: _prev: import ../pkgs final.pkgs;

  # This one contains whatever you want to overlay
  # You can change versions, add patches, set compilation flags, anything really.
  # https://nixos.wiki/wiki/Overlays
  modifications = final: prev: {
    # example = prev.example.overrideAttrs (oldAttrs: rec {
    # ...
    # });
    intel-vaapi-driver = prev.intel-vaapi-driver.override {
     enableHybridCodec = true;
    };
    # Discord sucks. Use vesktop lol.
    # discord = prev.discord.override {
    #  withOpenASAR = true;
    #  withVencord = true;
    # };
    hyprland-flake = inputs.hyprland.packages.${final.system}.hyprland;
    hyprland-plugins = inputs.hyprland-plugins.packages.${final.system};
    nix-vscode-extensions = inputs.nix-vscode-extensions.extensions.${final.system};
  };

  # When applied, the unstable nixpkgs set (declared in the flake inputs) will
  # be accessible through 'pkgs.unstable'
  unstable-packages = final: _prev: {
    unstable = import inputs.nixpkgs-unstable {
      system = final.system;
      config.allowUnfree = true;
    };
  };
}
