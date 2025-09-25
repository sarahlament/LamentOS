{
	conf,
	lib,
	pkgs,
	...
}: {
	fileSystems."/" = {
		device = "/dev/worksys/sys";
		fsType = "ext4";
	};
	fileSystems."/efi" = {
		device = "/dev/disk/by-label/NIXBOOT";
		fsType = "vfat";
		options = [
			"fmask=0077"
			"dmask=0077"
		];
	};
	swapDevices = [{device = "/dev/worksys/swap";}];
}
