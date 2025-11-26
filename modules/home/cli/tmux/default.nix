{ config, lib, pkgs, ... }:

let
  cfg = config.flexnix.modules.cli.tmux;
  
  # Load external configurations
  pluginList = import ./plugins.nix { inherit pkgs; };
  configString = import ./config.nix;
in
{
  options.flexnix.modules.cli.tmux = {
    enable = lib.mkEnableOption "Tmux terminal multiplexer";
  };

  config = lib.mkIf cfg.enable {
    # 1. Dependencies
    home.packages = with pkgs; [ 
      xclip   # Clipboard support
      thumbs  # Hint utility
    ];

    # 2. Program Configuration
    programs.tmux = {
      enable = true;
      clock24 = true;
      mouse = true;
      keyMode = "vi";
      prefix = "C-a";
      
      # Load from external files
      plugins = pluginList;
      extraConfig = configString;
    };
  };
}
