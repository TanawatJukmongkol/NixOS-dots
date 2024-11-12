{
	...
}:
{
	specialisation = {
		no-patch.configuration = {
			system.nixos.tags = [ "no-patch" ];
			environment.etc."specialisation".text = "no-patch";
			boot = {
				loader = {
					grub.extraConfig = "";
				};
				extraModulePackages = [];
			};
		};
	};
}
