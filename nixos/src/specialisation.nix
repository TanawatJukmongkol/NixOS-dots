{
	...
}:
{
	specialisation = {
		no-acpi-patch.configuration = {
			system.nixos.tags = [ "no-acpi-patch" ];
			boot.loader = {
				grub.extraConfig = null;
			};
		};
	};
}
