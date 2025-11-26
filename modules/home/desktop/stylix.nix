{ pkgs, lib, config, inputs, ... }:

let
  cfg = config.flexnix.modules.desktop.stylix;
in
{
  imports = [
    inputs.stylix.homeModules.stylix
  ];

  options.flexnix.modules.desktop.stylix = {
    enable = lib.mkEnableOption "System-wide theming via Stylix";
  };

  config = lib.mkIf cfg.enable {
    stylix = {
      enable = true;
      
      # Wallpaper path (Relative to the flake root is safer if using self, 
      # but relative paths in imports work too)
      image = ../../../assets/wallpapers/Anime-Girl-Night-Sky.jpg; 

      # Color Scheme (Gruvbox Dark Hard)
      base16Scheme = "${pkgs.base16-schemes}/share/themes/gruvbox-dark-hard.yaml";
      
      # Transparency & Polarity
      polarity = "dark";
      opacity = {
        terminal = 0.9;
        applications = 0.9;
        desktop = 0.9;
      };

      # Fonts
      fonts = {
        monospace = {
          package = pkgs.nerd-fonts.jetbrains-mono;
          name = "JetBrainsMono Nerd Font";
        };
        sansSerif = {
          package = pkgs.dejavu_fonts;
          name = "DejaVu Sans";
        };
        serif = {
          package = pkgs.dejavu_fonts;
          name = "DejaVu Serif";
        };
      };

      # Target Specifics (What to style)
      targets = {
        vscode.enable = true;    # Style VSCode
        neovim.enable = false;   # Let NVF handle its own theme
        kitty.enable = true;     # Style Kitty
        alacritty.enable = true; # Style Alacritty
        fzf.enable = true;
        bat.enable = true;
        yazi.enable = true;
      };
    };
  };
}
