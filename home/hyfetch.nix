{
  config,
  lib,
  pkgs,
  ...
}: {
  programs = {
    hyfetch = {
      enable = true;
      settings = {
        preset = "transfeminine";
        mode = "rgb";
        light_dark = "dark";
        lightness = 0.65;
        color_align = {
          mode = "horizontal";
        };
        backend = "fastfetch";
        pride_month_disable = false;
      };
    };

    # fancy system info parser thingy
    fastfetch = {
      enable = true;
      settings = {
        "$schema" = "https://github.com/fastfetch-cli/fastfetch/raw/dev/doc/json_schema.json";
        logo = {
          type = "auto";
        };
        display = {
          separator = "  ";
        };
        modules = [
          "break"
          {
            type = "custom";
            format = "╭─ System ─────────────────────────────────────────────────────╮";
            outputColor = "38;2;137;180;250"; # Catppuccin blue
          }
          {
            type = "os";
            key = "│ OS";
            keyColor = "38;2;137;180;250";
          }
          {
            type = "host";
            key = "│ Host";
            keyColor = "38;2;137;180;250";
          }
          {
            type = "kernel";
            key = "│ Kernel";
            keyColor = "38;2;137;180;250";
          }
          {
            type = "uptime";
            key = "│ Uptime";
            keyColor = "38;2;137;180;250";
          }
          {
            type = "packages";
            key = "│ Packages";
            keyColor = "38;2;137;180;250";
          }
          {
            type = "shell";
            key = "│ Shell";
            keyColor = "38;2;137;180;250";
          }
          {
            type = "terminal";
            key = "│ Terminal";
            keyColor = "38;2;137;180;250";
          }
          {
            type = "custom";
            format = "╰──────────────────────────────────────────────────────────────╯";
            outputColor = "38;2;137;180;250";
          }
          {
            type = "custom";
            format = "╭─ Desktop ────────────────────────────────────────────────────╮";
            outputColor = "38;2;250;179;135"; # Catppuccin peach
          }
          {
            type = "wm";
            key = "│ WM";
            keyColor = "38;2;250;179;135";
          }
          {
            type = "wmtheme";
            key = "│ WM Theme";
            keyColor = "38;2;250;179;135";
          }
          {
            type = "theme";
            key = "│ Theme";
            keyColor = "38;2;250;179;135";
          }
          {
            type = "cursor";
            key = "│ Cursor";
            keyColor = "38;2;250;179;135";
          }
          {
            type = "icons";
            key = "│ Icons";
            keyColor = "38;2;250;179;135";
          }
          {
            type = "font";
            key = "│ Font";
            keyColor = "38;2;250;179;135";
          }
          {
            type = "terminalfont";
            key = "│ Term Font";
            keyColor = "38;2;250;179;135";
          }
          {
            type = "custom";
            format = "╰──────────────────────────────────────────────────────────────╯";
            outputColor = "38;2;250;179;135";
          }
          {
            type = "custom";
            format = "╭─ Hardware ───────────────────────────────────────────────────╮";
            outputColor = "38;2;166;227;161"; # Catppuccin green
          }
          {
            type = "cpu";
            key = "│ CPU";
            keyColor = "38;2;166;227;161";
          }
          {
            type = "gpu";
            key = "│ GPU";
            keyColor = "38;2;166;227;161";
          }
          {
            type = "sound";
            key = "│ Sound";
            keyColor = "38;2;166;227;161";
          }
          {
            type = "memory";
            key = "│ Memory";
            keyColor = "38;2;166;227;161";
          }
          {
            type = "swap";
            key = "│ Swap";
            keyColor = "38;2;166;227;161";
          }
          {
            type = "disk";
            key = "│ Disk";
            keyColor = "38;2;166;227;161";
          }
          {
            type = "custom";
            format = "╰──────────────────────────────────────────────────────────────╯";
            outputColor = "38;2;166;227;161";
          }
          {
            type = "custom";
            format = "╭─ Info ───────────────────────────────────────────────────────╮";
            outputColor = "38;2;203;166;247"; # Catppuccin mauve
          }
          {
            type = "title";
            fqdn = true;
            key = "│ User";
            keyColor = "38;2;203;166;247";
            color = {
              user = "bright_white";
              at = "bright_white";
              host = "bright_white";
            };
          }
          {
            type = "localip";
            key = "│ Local IP";
            keyColor = "38;2;203;166;247";
          }
          {
            type = "publicip";
            key = "│ Public IP";
            keyColor = "38;2;203;166;247";
            format = "{ip}";
            timeout = 3000;
          }
          {
            type = "command";
            key = "│ Public IPv6";
            keyColor = "38;2;203;166;247";
            text = "curl -s --max-time 3 https://ipv6.icanhazip.com 2>/dev/null || echo 'N/A'";
          }
          {
            type = "locale";
            key = "│ Locale";
            keyColor = "38;2;203;166;247";
          }
          {
            type = "weather";
            key = "│ Weather";
            keyColor = "38;2;203;166;247";
            location = "Fort Worth, Texas";
            timeout = 3000;
          }
          {
            type = "custom";
            format = "╰──────────────────────────────────────────────────────────────╯";
            outputColor = "38;2;203;166;247";
          }
          "break"
          {
            type = "colors";
            symbol = "circle";
          }
          "break"
        ];
      };
    };

    direnv = {
      enable = true;
      silent = true;
    };
  };
}
