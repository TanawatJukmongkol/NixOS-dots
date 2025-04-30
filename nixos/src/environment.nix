{
  pkgs,
  config,
  ...
}:
{
	environment.sessionVariables = {
		LD_LIBRARY_PATH = [
			"/run/opengl-driver/lib:/run/opengl-driver-32/lib:${config.boot.kernelPackages.nvidia_x11}"
		];
		EXTRA_LDFLAGS="-L/lib -L${config.boot.kernelPackages.nvidia_x11}/lib";
	};
}
