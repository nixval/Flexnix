{ config, lib, pkgs, ... }:

let
  cfg = config.flexnix.modules.languages.python;
in
{
  options.flexnix.modules.languages.python = {
    enable = lib.mkEnableOption "Python 3 environment";
  };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      python3
      # Add virtualenv or other python tools here if needed
    ];
  };
}
