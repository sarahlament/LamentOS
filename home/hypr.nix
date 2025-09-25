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
	taskman = "btop";
	menu = "wofi";
in {
	# Let's enable both GTK and QT at the system level so Stylix does its thing
	gtk.enable = true;
	qt.enable = true;

	# Use the modern, preferred module for Hyprland on unstable
	wayland.windowManager.hyprland = {
		enable = true;
		xwayland.enable = true;

		# All settings are placed here
		settings = {
			ecosystem.no_update_news = true;

			# Monitors
			monitor = ",highres,auto,auto";

			# Autostart (exec-once)
			"exec-once" = [
				"wl-clip-persist --type text --watch cliphist store"
				"wl-clip-persist --type image --watch cliphist store"
				"discord --no-sandbox --start-minimized"
				"sudo headsetcontrol -s128"
				"steam -silent"
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

			# General
			general = {
				gaps_in = 5;
				gaps_out = 20;
				border_size = 2;
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
					# Original curves
					"easeOutQuint,0.23,1,0.32,1"
					"easeInOutCubic,0.65,0.05,0.36,1"
					"easeOutBack,0.34,1.56,0.64,1"
					"easeOutElastic,0.05,0.7,0.1,1.05"
					"smoothBounce,0.25,0.46,0.45,0.94"
					"linear,0,0,1,1"
					"almostLinear,0.5,0.5,0.75,1.0"
					"quick,0.15,0,0.1,1"

					# ML4W curves - borrowed from MyLinux4Work dotfiles
					"overshot,0.05,0.9,0.1,1.1" # ML4W signature bounce
					"md3_decel,0.05,0.7,0.1,1" # ML4W smooth deceleration
				];
				animation = [
					"global, 1, 10, default"
					"border, 1, 6, easeOutQuint"
					"windows, 1, 5.5, easeInOutCubic"

					# ML4W inspired animations
					"windowsIn, 1, 3, overshot, popin 60%" # ML4W standard bounce for new windows
					"workspaces, 1, 7, overshot, slide" # ML4W workspace switching with bounce
					"workspacesIn, 1, 3, overshot, slide" # ML4W workspace entrance
					"workspacesOut, 1, 3, md3_decel, slide" # ML4W smooth workspace exit

					# Keep smooth for exits and fades
					"windowsOut, 1, 2, easeOutQuint, popin 90%"
					"fadeIn, 1, 2.5, md3_decel" # Smoother fade with ML4W curve
					"fadeOut, 1, 2, easeInOutCubic"
					"fade, 1, 3, md3_decel" # ML4W smooth fade

					# Layer animations with ML4W timing
					"layers, 1, 4.5, easeOutBack"
					"layersIn, 1, 3, md3_decel, slide" # ML4W layer entrance
					"layersOut, 1, 2, easeInOutCubic, slide"
					"fadeLayersIn, 1, 2, md3_decel" # ML4W layer fade
					"fadeLayersOut, 1, 2, easeInOutCubic"
				];
			};

			# Layouts
			dwindle = {
				pseudotile = true;
				preserve_split = true;
			};
			master.new_status = "master";

			# Workspaces
			workspace = "1, monitor:DP-2";

			# Window Rules
			windowrulev2 = [
				"suppressevent maximize, class:.*"
				"nofocus,class:^$,title:^$,xwayland:1,floating:1,fullscreen:0,pinned:0"
			];

			# Keybinds (vim-style direct bindings)
			bind = [
				# Applications
				"${mainMod}, RETURN, exec, ${terminal}"
				"${mainMod}, B, exec, ${browser}"
				"${mainMod}, BRACKETRIGHT, exec, discord"
				"${mainMod}, E, exec, ${fileManager}"
				"${mainMod}, D, exec, ${menu} --show drun"
				"${mainMod} SHIFT, S, exec, pypr toggle term" # Scratchpad
				"${mainMod} SHIFT, V, exec, codium"
				"${mainMod} SHIFT, G, exec, steam"

				# Window operations
				"${mainMod}, Q, killactive,"
				"${mainMod}, F, fullscreen,"
				"${mainMod}, V, togglefloating,"
				"${mainMod}, S, togglesplit,"

				# Window focus (vim-style)
				"${mainMod}, H, movefocus, l"
				"${mainMod}, J, movefocus, d"
				"${mainMod}, K, movefocus, u"
				"${mainMod}, L, movefocus, r"

				# Move windows within workspace
				"${mainMod} SHIFT, H, movewindow, l"
				"${mainMod} SHIFT, J, movewindow, d"
				"${mainMod} SHIFT, K, movewindow, u"
				"${mainMod} SHIFT, L, movewindow, r"

				# Workspace switching
				"${mainMod}, 1, workspace, 1"
				"${mainMod}, 2, workspace, 2"
				"${mainMod}, 3, workspace, 3"
				"${mainMod}, 4, workspace, 4"
				"${mainMod}, 5, workspace, 5"
				"${mainMod}, 6, workspace, 6"
				"${mainMod}, 7, workspace, 7"
				"${mainMod}, 8, workspace, 8"
				"${mainMod}, 9, workspace, 9"
				"${mainMod}, 0, workspace, 10"

				# Move window to workspace (and follow)
				"${mainMod} CTRL, 1, movetoworkspace, 1"
				"${mainMod} CTRL, 2, movetoworkspace, 2"
				"${mainMod} CTRL, 3, movetoworkspace, 3"
				"${mainMod} CTRL, 4, movetoworkspace, 4"
				"${mainMod} CTRL, 5, movetoworkspace, 5"
				"${mainMod} CTRL, 6, movetoworkspace, 6"
				"${mainMod} CTRL, 7, movetoworkspace, 7"
				"${mainMod} CTRL, 8, movetoworkspace, 8"
				"${mainMod} CTRL, 9, movetoworkspace, 9"
				"${mainMod} CTRL, 0, movetoworkspace, 10"

				# Move window to workspace (don't follow)
				"${mainMod} ALT, 1, movetoworkspacesilent, 1"
				"${mainMod} ALT, 2, movetoworkspacesilent, 2"
				"${mainMod} ALT, 3, movetoworkspacesilent, 3"
				"${mainMod} ALT, 4, movetoworkspacesilent, 4"
				"${mainMod} ALT, 5, movetoworkspacesilent, 5"
				"${mainMod} ALT, 6, movetoworkspacesilent, 6"
				"${mainMod} ALT, 7, movetoworkspacesilent, 7"
				"${mainMod} ALT, 8, movetoworkspacesilent, 8"
				"${mainMod} ALT, 9, movetoworkspacesilent, 9"
				"${mainMod} ALT, 0, movetoworkspacesilent, 10"

				# Monitor management
				"${mainMod}, comma, focusmonitor, DP-1"
				"${mainMod}, period, focusmonitor, DP-2"
				"${mainMod} SHIFT, comma, movecurrentworkspacetomonitor, DP-1"
				"${mainMod} SHIFT, period, movecurrentworkspacetomonitor, DP-2"
				"${mainMod} ALT, comma, movewindow, mon:DP-1"
				"${mainMod} ALT, period, movewindow, mon:DP-2"

				# Mouse workspace switching
				"${mainMod}, mouse_down, workspace, e+1"
				"${mainMod}, mouse_up, workspace, e-1"

				# System
				"${mainMod} SHIFT ALT, M, exec, systemctl poweroff"

				# Resize submap
				"${mainMod} SHIFT, R, submap, resize"

				# Classic Windows keybind cuz I'm used to it
				"CTRL SHIFT, escape, exec, pypr toggle taskman"
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

		# Resize submap for fine window control
		submaps.resize.settings = {
			binde = [
				# Vim-style resize bindings (smoother increments)
				", H, resizeactive, -10 0"
				", L, resizeactive, 10 0"
				", K, resizeactive, 0 -10"
				", J, resizeactive, 0 10"

				# Shift for bigger increments
				"SHIFT, H, resizeactive, -50 0"
				"SHIFT, L, resizeactive, 50 0"
				"SHIFT, K, resizeactive, 0 -50"
				"SHIFT, J, resizeactive, 0 50"
			];
			bind = [
				", escape, submap, reset"
				", RETURN, submap, reset"
				", q, submap, reset"
			];
		};
	};

	# Services needed for the Hyprland environment
	services = {
		hyprpolkitagent.enable = true;
		hyprpaper = {
			enable = true;
		};
		hypridle = {
			enable = true;
			settings = {
				general = {
					after_sleep_cmd = "hyprctl dispatch dpms on";
					before_sleep_cmd = "loginctl lock-session";
					ignore_dbus_inhibit = false;
					lock_cmd = "hyprlock";
				};

				listener = [
					{
						timeout = 150; # 2.5 minutes - dim screen
						on-timeout = "brightnessctl -s set 10";
						on-resume = "brightnessctl -r";
					}
					{
						timeout = 300; # 5 minutes - lock screen
						on-timeout = "loginctl lock-session";
					}
					{
						timeout = 330; # 5.5 minutes - turn off display
						on-timeout = "hyprctl dispatch dpms off";
						on-resume = "hyprctl dispatch dpms on";
					}
					{
						timeout = 1800; # 30 minutes - suspend
						on-timeout = "systemctl suspend";
					}
				];
			};
		};
	};

	programs.waybar = {
		enable = true;
		systemd.enable = true;
		settings = {
			mainBar = {
				layer = "top";
				position = "top";
				height = 40;
				spacing = 4;

				# Left modules
				modules-left = [ "hyprland/workspaces" "hyprland/mode" "wlr/scratchpad" ];

				# Center modules
				modules-center = [ "hyprland/window" ];

				# Right modules
				modules-right = [
					"idle_inhibitor"
					"wireplumber"
					"network"
					"cpu"
					"memory"
					"temperature"
					"clock"
					"tray"
					"custom/power"
				];

				# Module configurations
				"hyprland/workspaces" = {
					disable-scroll = true;
					all-outputs = true;
					warp-on-scroll = false;
					format = "{icon}";
					format-icons = {
						"1" = "󰲠";
						"2" = "󰲢";
						"3" = "󰲤";
						"4" = "󰲦";
						"5" = "󰲨";
						"6" = "󰲪";
						"7" = "󰲬";
						"8" = "󰲮";
						"9" = "󰲰";
						"10" = "󰿬";
						urgent = "󰀪";
						focused = "󰮯";
						default = "󰧞";
					};
				};

				"hyprland/mode" = {
					format = "<span style=\"italic\">{}</span>";
				};

				"wlr/scratchpad" = {
					format = "{icon} {count}";
					show-empty = false;
					format-icons = ["󰏃" "󰏀"];
					tooltip = true;
					tooltip-format = "{app}: {title}";
				};

				"hyprland/window" = {
					format = "{}";
					max-length = 50;
					separate-outputs = true;
				};

				"idle_inhibitor" = {
					format = "{icon}";
					format-icons = {
						activated = "󰅶";
						deactivated = "󰾪";
					};
				};

				tray = {
					spacing = 10;
				};

				clock = {
					timezone = "America/New_York";
					tooltip-format = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
					format = " {:%H:%M}";
					format-alt = " {:%Y-%m-%d}";
				};

				cpu = {
					format = "󰘚 {usage}%";
					tooltip = false;
					on-click = "pypr toggle taskman";
				};

				memory = {
					format = "󰍛 {}%";
					on-click = "pypr toggle taskman";
				};

				temperature = {
					thermal-zone = 2;
					hwmon-path = "/sys/class/hwmon/hwmon2/temp1_input";
					critical-threshold = 80;
					format-critical = "󰸁 {temperatureC}°C";
					format = "󰔏 {temperatureC}°C";
				};

				network = {
					format-wifi = "󰤨 {signalStrength}%";
					format-ethernet = "󰈀 {ipaddr}/{cidr}";
					tooltip-format = "󰈀 {ifname} via {gwaddr}";
					format-linked = "󰈀 {ifname} (No IP)";
					format-disconnected = "󰈂 Disconnected";
					format-alt = "{ifname}: {ipaddr}/{cidr}";
				};

				wireplumber = {
					format = "{icon} {volume}%";
					format-muted = "󰝟 {format_source}";
					format-source = "󰍬 {volume}%";
					format-source-muted = "󰍭";
					format-icons = {
						headphone = "󰋋";
						hands-free = "󰋎";
						headset = "󰋎";
						phone = "󰏲";
						portable = "󰦢";
						car = "󰄋";
						default = ["󰕿" "󰖀" "󰕾"];
					};
					on-click = "pavucontrol";
					scroll-step = 5;
				};

				"custom/power" = {
					format = "󰐥";
					tooltip = false;
					on-click = "~/.config/waybar/power-menu.sh";
				};
			};
		};

		style = with config.lib.stylix.colors.withHashtag; ''
			@define-color base00 ${base00}; @define-color base01 ${base01};
			@define-color base02 ${base02}; @define-color base03 ${base03};
			@define-color base04 ${base04}; @define-color base05 ${base05};
			@define-color base06 ${base06}; @define-color base07 ${base07};

			@define-color base08 ${base08}; @define-color base09 ${base09};
			@define-color base0A ${base0A}; @define-color base0B ${base0B};
			@define-color base0C ${base0C}; @define-color base0D ${base0D};
			@define-color base0E ${base0E}; @define-color base0F ${base0F};

			* {
				border: none;
				border-radius: 0;
				font-family: "JetBrainsMono Nerd Font", monospace;
				font-size: 13px;
				min-height: 0;
			}

			window#waybar {
				background-color: alpha(@base00, 0.9);
				border-bottom: 3px solid alpha(@base03, 0.5);
				color: @base05;
				transition-property: background-color;
				transition-duration: .5s;
			}

			window#waybar.hidden {
				opacity: 0.2;
			}

			button {
				box-shadow: inset 0 -3px transparent;
				border: none;
				border-radius: 0;
			}

			button:hover {
				background: inherit;
				box-shadow: inset 0 -3px @base05;
			}

			#workspaces button {
				padding: 0 5px;
				background-color: transparent;
				color: @base05;
			}

			#workspaces button:hover {
				background: alpha(@base00, 0.2);
			}

			#workspaces button.focused {
				background-color: @base03;
				box-shadow: inset 0 -3px @base05;
			}

			#workspaces button.urgent {
				background-color: @base08;
			}

			#mode {
				background-color: @base03;
				border-bottom: 3px solid @base05;
			}

			#clock,
			#cpu,
			#memory,
			#disk,
			#temperature,
			#backlight,
			#network,
			#wireplumber,
			#custom-media,
			#tray,
			#mode,
			#idle_inhibitor,
			#scratchpad,
			#mpd,
			#custom-power {
				padding: 0 10px;
				color: @base05;
			}

			#window,
			#workspaces {
				margin: 0 4px;
			}

			.modules-left > widget:first-child > #workspaces {
				margin-left: 0;
			}

			.modules-right > widget:last-child > #workspaces {
				margin-right: 0;
			}

			#clock {
				background-color: @base03;
			}

			label:focus {
				background-color: @base00;
			}

			#cpu {
				background-color: @base0B;
				color: @base00;
			}

			#memory {
				background-color: @base0E;
			}

			#disk {
				background-color: @base09;
			}

			#backlight {
				background-color: @base0C;
			}

			#network {
				background-color: @base0D;
			}

			#network.disconnected {
				background-color: @base08;
			}

			#wireplumber {
				background-color: @base0A;
				color: @base00;
			}

			#wireplumber.muted {
				background-color: @base03;
				color: @base04;
			}

			#temperature {
				background-color: @base09;
			}

			#temperature.critical {
				background-color: @base08;
			}

			#tray {
				background-color: @base0D;
			}

			#idle_inhibitor {
				background-color: @base01;
			}

			#idle_inhibitor.activated {
				background-color: @base06;
				color: @base01;
			}

			#scratchpad {
				background-color: @base0B;
				color: @base00;
			}

			#scratchpad.empty {
				background-color: transparent;
			}

			#custom-power {
				background-color: @base08;
				color: @base00;
			}

			#custom-power:hover {
				background-color: alpha(@base08, 0.8);
			}
		'';
	};

	# Declaratively manage the pyprland config
	home.file.".config/hypr/pyprland.toml" = {
		text = ''
			[pyprland]
			plugins = [ "scratchpads" ]

			[scratchpads.term]
			command = "kitty --class kitty-dropterm"
			class = "kitty-dropterm"
			animation = "fromTop"
			size = "75% 80%"
			margin = 50

			[scratchpads.taskman]
			command = "kitty --class kitty-htop ${taskman}"
			class = "kitty-htop"
			animation = "fromTop"
			size = "80% 60%"
			margin = 50
		'';
	};

	# Power menu script
	home.file.".config/waybar/power-menu.sh" = {
		text = ''
			#!/usr/bin/env bash

			# Power menu options
			options="󰐥 Power Off\n󰜉 Restart\n󰋊 Hibernate\n󰍃 Logout\n󰌾 Lock"

			# Show menu with wofi
			chosen=$(echo -e "$options" | wofi --dmenu \
				--prompt "Power Menu" \
				--width 300 \
				--height 250 \
				--cache-file /dev/null \
				--hide-scroll \
				--no-actions)

			# Execute chosen action
			case $chosen in
				"󰐥 Power Off")
					systemctl poweroff
					;;
				"󰜉 Restart")
					systemctl reboot
					;;
				"󰋊 Hibernate")
					systemctl hibernate
					;;
				"󰍃 Logout")
					hyprctl dispatch exit
					;;
				"󰌾 Lock")
					loginctl lock-session
					;;
			esac
		'';
		executable = true;
	};
}
