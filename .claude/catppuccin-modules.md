# Catppuccin Nix Module Behavior

## Hyprland Module (`catppuccin.hyprland`)

**What it does**: Sources pre-built `.conf` files with color variables
**Variable format**: `$variable` (e.g., `$mauve`, `$lavender`, `$base`)
**Implementation**:
```nix
wayland.windowManager.hyprland = {
  settings = {
    source = [
      "${sources.hyprland}/${cfg.flavor}.conf"  # Contains $mauve = #cba6f7 etc.
    ];
  };
};
```

**Usage**: Reference variables in Hyprland config
```nix
"col.active_border" = "$mauve $lavender 45deg";
"col.inactive_border" = "$surface0";  
decoration.shadow.color = "$base";
```

## Waybar Module (`catppuccin.waybar`)

**What it does**: Prepends `@import` of CSS color definitions
**Variable format**: `@variable` (e.g., `@text`, `@mauve`, `@green`)
**Implementation**:
```nix
programs.waybar = {
  style = lib.mkBefore ''
    @import "${styleFile}";  # Contains @define-color text #cdd6f4; etc.
  '';
};
```

**Usage**: Reference variables in waybar CSS
```css
color: @text;
border: 2px solid @surface0;
background: @mauve;
```

## Available Variables

Both modules provide the full catppuccin palette:
- `$/@{rosewater,flamingo,pink,mauve,red,maroon,peach,yellow}`
- `$/@{green,teal,sky,sapphire,blue,lavender}`  
- `$/@{text,subtext1,subtext0,overlay2,overlay1,overlay0}`
- `$/@{surface2,surface1,surface0,base,mantle,crust}`