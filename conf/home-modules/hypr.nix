{
	config,
	pkgs,
	lib,
	...
}: let
	# Define variables for keybinds for consistency and readability
	mainMod = "SUPER";
	terminal = "kitty";
	browser = "flatpak run app.zen_browser.zen";
	fileManager = "dolphin";
	menu = "wofi --show drum";
in {
	# Use the modern, preferred module for Hyprland on unstable
	wayland.windowManager.hyprland = {
		enable = true;
		xwayland.enable = true;

		# All settings are placed here
		settings = {
			# Monitors
			monitor = ",highres,auto,auto";

			# Autostart (exec-once)
			"exec-once" = [
				"wl-clip-persist --type text --watch cliphist store"
				"wl-clip-persist --type image --watch cliphist store"
				"discord --no-sandbox --start-minimized"
				"headsetcontrol -s128"
				"pypr" # For scratchpads
				"hyprctl dispatch workspace 1" # Move to workspace 1 on start
			];

			# Input
			input = {
				kb_layout = "us";
				follow_mouse = 1;
				natural_scroll = 1;
				sensitivity = 0;
				numlock_by_default = true;
			};
			gestures.workspace_swipe = false;

			# General
			general = {
				gaps_in = 5;
				gaps_out = 20;
				border_size = 2;
				"col.active_border" = "rgba(33ccffee) rgba(00ff99ee) 45deg";
				"col.inactive_border" = "rgba(595959aa)";
				resize_on_border = false;
				allow_tearing = false;
				layout = "dwindle";
			};

			# Decoration
			decoration = {
				rounding = 10;
				active_opacity = 1.0;
				inactive_opacity = 1.0;
				shadow = {
					enabled = true;
					range = 4;
					render_power = 3;
					color = "rgba(1a1a1aee)";
				};
				blur = {
					enabled = true;
					size = 3;
					passes = 1;
					vibrancy = 0.1696;
				};
			};

			# Animations
			animations = {
				enabled = "yes";
				bezier = [
					"easeOutQuint,0.23,1,0.32,1"
					"easeInOutCubic,0.65,0.05,0.36,1"
					"linear,0,0,1,1"
					"almostLinear,0.5,0.5,0.75,1.0"
					"quick,0.15,0,0.1,1"
				];
				animation = [
					"global, 1, 10, default"
					"border, 1, 5.39, easeOutQuint"
					"windows, 1, 4.79, easeOutQuint"
					"windowsIn, 1, 4.1, easeOutQuint, popin 87%"
					"windowsOut, 1, 1.49, linear, popin 87%"
					"fadeIn, 1, 1.73, almostLinear"
					"fadeOut, 1, 1.46, almostLinear"
					"fade, 1, 3.03, quick"
					"layers, 1, 3.81, easeOutQuint"
					"layersIn, 1, 4, easeOutQuint, fade"
					"layersOut, 1, 1.5, linear, fade"
					"fadeLayersIn, 1, 1.79, almostLinear"
					"fadeLayersOut, 1, 1.39, almostLinear"
					"workspaces, 1, 1.94, almostLinear, fade"
					"workspacesIn, 1, 1.21, almostLinear, fade"
					"workspacesOut, 1, 1.94, almostLinear, fade"
				];
			};

			# Layouts
			dwindle = {
				pseudotile = true;
				preserve_split = true;
			};
			master.new_status = "master";

			# Misc
			misc = {
				force_default_wallpaper = -1;
				disable_hyprland_logo = false;
			};

			# Workspaces
			workspace = "1, monitor:DP-2";

			# Window Rules
			windowrulev2 = [
				"suppressevent maximize, class:.*"
				"nofocus,class:^$,title:^$,xwayland:1,floating:1,fullscreen:0,pinned:0"
			];

			# Keybinds (organized by type)
			bind = [
				"${mainMod}, RETURN, exec, ${terminal}"
				"${mainMod}, B, exec, ${browser}"
				"${mainMod}, BRACKETRIGHT, exec, discord"
				"${mainMod}, Q, killactive,"
				"${mainMod}, M, exec, uwsm stop"
				"${mainMod}, E, exec, ${fileManager}"
				"${mainMod}, V, togglefloating,"
				"${mainMod}, R, exec, ${menu}"
				"${mainMod}, J, togglesplit,"
				"${mainMod}, left, movefocus, l"
				"${mainMod}, right, movefocus, r"
				"${mainMod}, up, movefocus, u"
				"${mainMod}, down, movefocus, d"
				"${mainMod}, 1, workspace, 1"
				"${mainMod}, 2, workspace, 2"
				"${mainMod}, 3, workspace, 3"
				"${mainMod}, 4, workspace, 4"
				"${mainMod}, 5, workspace, 5"
				"${mainMod}, 6, workspace, 6"
				"${mainMod} SHIFT, 1, movetoworkspace, 1"
				"${mainMod} SHIFT, 2, movetoworkspace, 2"
				"${mainMod} SHIFT, 3, movetoworkspace, 3"
				"${mainMod} SHIFT, 4, movetoworkspace, 4"
				"${mainMod} SHIFT, 5, movetoworkspace, 5"
				"${mainMod} SHIFT, 6, movetoworkspace, 6"
				"${mainMod}, mouse_down, workspace, e+1"
				"${mainMod}, mouse_up, workspace, e-1"
				"${mainMod} SHIFT, S, exec, pypr toggle term" # Scratchpad
				"${mainMod} SHIFT, R, submap, resize" # Enter resize submap
			];
			bindm = [
				"${mainMod} SHIFT, mouse:272, movewindow"
				"${mainMod} SHIFT, mouse:273, resizewindow"
			];
			bindel = [
				",XF86AudioRaiseVolume, exec, wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"
				",XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
				",XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
			];
			bindl = [
				", XF86AudioNext, exec, playerctl next"
				", XF86AudioPause, exec, playerctl play-pause"
				", XF86AudioPlay, exec, playerctl play-pause"
				", XF86AudioPrev, exec, playerctl previous"
			];
		};

		# Submaps for modal keybindings
		submaps.resize.settings = {
			binde = [
				", right, resizeactive, 20 0"
				", left, resizeactive, -20 0"
				", up, resizeactive, 0 -20"
				", down, resizeactive, 0 20"
			];
			bind = [
				", escape, submap, reset"
			];
		};
	};

	# XDG portal configuration
	home.preferXdgDirectories = true;
	xdg.portal = {
		enable = true;
		extraPortals = with pkgs; [
			xdg-desktop-portal-gtk
		];
		configPackages = [pkgs.hyprland];
	};

	# Services needed for the Hyprland environment
	services = {
		hyprpolkitagent.enable = true;
		hyprpaper = {
			enable = true;
			settings = {
				preload = ["${config.home.homeDirectory}/Pictures/wallpaper.png"];
				wallpaper = [",${config.home.homeDirectory}/Pictures/wallpaper.png"];
			};
		};
		hypridle = {
			enable = true;
		};
	};

	programs.waybar = {
		enable = true;
		systemd.enable = true;
	};

	# Declaratively manage the pyprland config
	home.file.".config/hypr/pyprland.toml" = {
		text = ''
			[pyprland]
			plugins = [ "scratchpads" ]

			[scratchpads.term]
			command = "kitty --class kitty-dropterm"
			class = "kitty-dropterm"
			animation = "fromBottom"
			size = "75% 60%"
			margin = 50
		'';
	};
}
