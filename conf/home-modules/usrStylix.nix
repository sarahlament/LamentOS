{
	config,
	lib,
	pkgs,
	...
}: {
	stylix = {
		# let's have nvim transparent
		targets.nixvim.transparentBackground = {
			main = true;
			numberLine = true;
			signColumn = true;
		};
	};
}
