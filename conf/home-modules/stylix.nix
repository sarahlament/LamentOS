{
	config,
	pkgs,
	lib,
	...
}: {
	# Enable Stylix theming system-wide
	stylix = {
		enable = true;
		polarity = "dark";

		# instead of using a wallpaper, let's instead create one based on a base16 theme
		base16Scheme = "${pkgs.base16-schemes}/share/themes/unikitty-dark.yaml";
		image = config.lib.stylix.pixel "base0A";

		cursor = {
			name = "Catppuccin Mocha Dark";
			package = pkgs.catppuccin-cursors.mochaDark;
			size = 32;
		};

		targets.kitty = {
			variant256Colors = true;
		};

		targets.nixvim = {
			transparentBackground = {
				main = true;
				numberLine = true;
				signColumn = true;
			};
		};

		# Configure fonts to match your preference
		fonts = {
			monospace = {
				package = pkgs.nerd-fonts.jetbrains-mono;
				name = "JetBrains Mono Nerd Font";
			};
			sansSerif = {
				package = pkgs.noto-fonts;
				name = "Noto Sans";
			};
			serif = {
				package = pkgs.noto-fonts;
				name = "Noto Serif";
			};
		};

		# Font sizes
		fonts.sizes = {
			applications = 12;
			terminal = 12;
			desktop = 10;
			popups = 10;
		};

		# Set opacity for various elements
		opacity = {
			applications = 1.0;
			terminal = 0.8;
			desktop = 1.0;
			popups = 0.95;
		};
	};
}
