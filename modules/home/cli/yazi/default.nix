{ config, lib, pkgs, ... }:

let
  cfg = config.flexnix.modules.cli.yazi;
  
  # Load external configurations
  settings = import ./settings.nix;
  keymap = import ./keymap.nix;
in
{
  options.flexnix.modules.cli.yazi = {
    enable = lib.mkEnableOption "Yazi file manager with plugins";
  };

  config = lib.mkIf cfg.enable {
    # 1. Runtime Dependencies (Previewers & Archives)
    home.packages = with pkgs; [
      yazi
      ffmpegthumbnailer # Video preview
      unzip             # Archive preview
      poppler-utils     # PDF preview
      ueberzugpp        # Image preview fallback
      ouch              # For 'ouch.yazi' plugin
    ];

    # 2. Main Configuration
    programs.yazi = {
      enable = true;
      enableZshIntegration = true;
      shellWrapperName = "y"; # Alias 'y' to cd on exit

      # External settings
      settings = settings;
      keymap = keymap;

      # Plugins (Declarative)
      plugins = with pkgs.yaziPlugins; {
        "full-border" = full-border;
        "starship" = starship;
        "toggle-pane" = toggle-pane;
        "chmod" = chmod;
        "git" = git;
        "lazygit" = lazygit;
        "ouch" = ouch;
        "sudo" = sudo;
      };

      # Lua Initialization
      initLua = ''
        require("full-border"):setup()
        require("starship"):setup()
      '';
    };
  };
}
