{
	config,
	pkgs,
	lib,
	...
}: {
	# Enable Stylix theming system-wide
	stylix = {
		targets.nixvim = {
			transparentBackground = {
				main = true;
				numberLine = true;
				signColumn = true;
			};
		};
	};
}
