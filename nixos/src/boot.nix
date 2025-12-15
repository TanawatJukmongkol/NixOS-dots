{
  lib,
  pkgs,
  config,
  ...
} :
{
  boot.kernelParams = [
	"acpi_backlight=native"
	"acpi_osi=Linux"
	"mem_sleep_default=s2idle"
	"pcie_aspm.policy=powersupersave"
	"intel_iommu=on"
	"iommu=pt"
	# "mem_sleep_default=deep"
  ];
  boot.supportedFilesystems = [ "ntfs" "btrfs" ];
  boot.loader = {
    efi.canTouchEfiVariables = true;
    grub = {
      enable = true;
      efiSupport = true;
      device = "nodev";
      useOSProber = true;
      configurationLimit = 10;
	  gfxmodeBios = "2560x1440";
	  gfxmodeEfi = "2560x1440";
	  extraFiles = {
        "dsdt.aml" = "${../patch/hpomen_acpi_patch.aml}";
        # "dsdt.cpio" = "${./hpomen_acpi_patch.cpio}";
      };
      extraConfig = ''''\n
acpi /dsdt.aml
GRUB_DEFAULT=saved
GRUB_SAVEDEFAULT=true
GRUB_GFXPAYLOAD_LINUX=keep
'';
    };
  };
  boot.plymouth = {
    enable = true;
    # add theme package and name
    themePackages = [ pkgs.mikuboot ];
    theme = "mikuboot";
  };

  boot.kernelPackages = pkgs.linuxKernel.packages.linux_6_17;
  boot.kernelModules = [
	"hp-wmi"
	"i915"
	"nvidia"
	"nvidia_modeset"
	"nvidia_uvm"
	"nvidia_drm"
	"v4l2loopback"
	"snd-aloop"
	"uinput"
	"i2c-dev"
	"i2c-piix4"
  ];
  boot.blacklistedKernelModules = [
  ];
  boot.extraModulePackages = [
	config.boot.kernelPackages.v4l2loopback.out
  ];

  boot.extraModprobeConfig = ''
options kvm_intel nested=1
options kvm_intel emulate_invalid_guest_state=0
options kvm ignore_msrs=1
options nvidia NVreg_RegistryDwords=EnableBrightnessControl=1
options nvidia NVreg_EnableBacklightHandler=1
  '';

  boot.initrd.luks.devices."luks-383e423f-1b75-4441-a46e-8d2ff891fb8a".device = "/dev/disk/by-uuid/383e423f-1b75-4441-a46e-8d2ff891fb8a";

}
