{
	config,
	lib,
	pkgs,
	...
}: {
	stylix = {
		enable = true;
		base16Scheme = "${pkgs.base16-schemes}/share/themes/tokyo-night-storm.yaml";
		image = ../wallpaper.png;
		cursor = {
			name = "Catppuccin Mocha Dark";
			package = pkgs.catppuccin-cursors.mochaDark;
			size = 32;
		};

		fonts = {
			monospace = {
				package = pkgs.nerd-fonts.jetbrains-mono;
				name = "JetBrains Mono Nerd Font";
			};
			sansSerif = {
				package = pkgs.inter;
				name = "Inter";
			};
			serif = {
				package = pkgs.source-serif-pro;
				name = "Source Serif";
			};
		};

		# Font sizes
		fonts.sizes = {
			applications = 12;
			terminal = 14;
			desktop = 10;
			popups = 10;
		};

		# Set opacity for various elements
		opacity = {
			applications = 0.8;
			terminal = 0.75;
			desktop = 0.5;
			popups = 0.95;
		};
	};
}
