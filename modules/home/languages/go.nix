{ config, lib, pkgs, ... }:

let
  cfg = config.flexnix.modules.languages.go;
in
{
  options.flexnix.modules.languages.go = {
    enable = lib.mkEnableOption "Go language toolchain";
  };

  config = lib.mkIf cfg.enable {
    programs.go = {
      enable = true;
      # Go path is automatically managed by Home Manager
    };
  };
}
