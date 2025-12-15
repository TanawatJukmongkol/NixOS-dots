{
	pkgs,
	...
} : {
  virtualisation.libvirtd = {
	  enable = true;
	  qemu = {
			ovmf.enable = true;
			ovmf.packages = with pkgs; [
				OVMF.fd
				pkgsCross.aarch64-multiplatform.OVMF.fd
			];
			verbatimConfig = ''
				# make libvirt use QEMU's firmware descriptors
				firmware_dirs = ["/var/lib/qemu/firmware"]
			'';
	  };
	};
 #  virtualisation.virtualbox = {
	# host = {
	# 	enable = true;
	# 	enableExtensionPack = true;
	# };
 #  };
  virtualisation.docker.rootless = {
    enable = true;
    setSocketVariable = true;
  };
  # virtualisation.docker = {
  #   enable = true;
  #   # storageDriver = "btrfs";
  # };
  virtualisation.waydroid.enable = true;
}
