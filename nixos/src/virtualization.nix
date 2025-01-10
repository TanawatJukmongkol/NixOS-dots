{
	pkgs,
	...
} : {
  virtualisation.libvirtd = {
	  enable = true;
	  qemu = {
		ovmf.packages = [
			pkgs.pkgsCross.aarch64-multiplatform.OVMF.fd
			pkgs.OVMF.fd
		];
	  };
  };
  virtualisation.virtualbox = {
	host = {
		enable = true;
		enableExtensionPack = true;
	};
  };
  virtualisation.docker.rootless = {
    enable = true;
    setSocketVariable = true;
  };
}
