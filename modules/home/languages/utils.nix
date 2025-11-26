{ config, lib, pkgs, ... }:

let
  cfg = config.flexnix.modules.languages.utils;
in
{
  options.flexnix.modules.languages.utils = {
    enable = lib.mkEnableOption "Utility languages (Lua, Nix formatters)";
  };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      stylua       # Lua formatter
      nixpkgs-fmt  # Nix formatter
    ];
  };
}
