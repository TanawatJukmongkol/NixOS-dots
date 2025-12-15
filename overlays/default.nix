{
  inputs,
  ...
}: {
  additions = final: _prev: import ../pkgs final.pkgs;

  modifications = final: prev: {
    intel-vaapi-driver = prev.intel-vaapi-driver.override {
      enableHybridCodec = true;
    };

    hyprland-flake = inputs.hyprland.packages.${final.system};
    hyprland-pkgs = inputs.hyprland.inputs.nixpkgs.legacyPackages.${final.system};
    hyprland-plugins = inputs.hyprland-plugins.packages.${final.system};
    hyprspace-flake = inputs.Hyprspace.packages.${final.system};
    prismlauncher-quacked = inputs.prismlauncher.packages.${final.system}.prismlauncher;
    envyctrl = inputs.envycontrol.packages.${final.system}.default;
    nix-vscode-extensions = inputs.nix-vscode-extensions.extensions.${final.system};
  };

  unstable-packages = final: _prev: {
    unstable = import inputs.nixpkgs-unstable {
      system = final.system;
      config.allowUnfree = true;
    };
  };
}
