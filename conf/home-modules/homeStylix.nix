{
	config,
	pkgs,
	lib,
	...
}: {
	# Enable Stylix theming system-wide
	stylix = {
		#image = ../../wallpaper.png;
		colorGeneration.polarity = "dark";
		targets.nixvim = {
			transparentBackground = {
				main = true;
				numberLine = true;
				signColumn = true;
			};
		};
	};
}
