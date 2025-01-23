{
  lib,
  pkgs,
  config,
  ...
} :
let
  realtek-kernel-module = pkgs.callPackage ./hda-realtek.nix { inherit (config.boot.kernelPackages) kernel; };
  patched = realtek-kernel-module.overrideAttrs (prev: {
    patches = [ ../patch/hda-realtek.patch ];
  });
in {
  boot.kernelParams = [ "acpi_backlight=native" "nvidia-drm.fbdev=1" ];
  boot.supportedFilesystems = [ "ntfs" "btrfs" ];
  boot.loader = {
    efi.canTouchEfiVariables = true;
    grub = {
      enable = true;
      efiSupport = true;
      device = "nodev";
      useOSProber = true;
      configurationLimit = 10;
      extraFiles = {
        "dsdt.aml" = "${../patch/hpomen_acpi_patch.aml}";
        # "dsdt.cpio" = "${./hpomen_acpi_patch.cpio}";
      };
      extraConfig = ''
        acpi /dsdt.aml
      '';
    };
  };

  boot.kernelModules = [ "uinput" "i2c-dev" "i2c-piix4" "nvidia_uvm" "hp-wmi" "v4l2loopback" "snd-aloop" ];
  boot.extraModulePackages = [
    (lib.hiPrio patched)
	config.boot.kernelPackages.v4l2loopback.out
  ];

  boot.extraModprobeConfig = ''
    options kvm_intel nested=1
    options kvm_intel emulate_invalid_guest_state=0
    options kvm ignore_msrs=1
  '';

  boot.initrd.luks.devices."luks-383e423f-1b75-4441-a46e-8d2ff891fb8a".device = "/dev/disk/by-uuid/383e423f-1b75-4441-a46e-8d2ff891fb8a";

}
