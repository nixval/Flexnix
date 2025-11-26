{ config, lib, pkgs, ... }:

let
  cfg = config.flexnix.modules.languages.javascript;
in
{
  options.flexnix.modules.languages.javascript = {
    enable = lib.mkEnableOption "JavaScript/Node.js toolchain";
  };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      nodejs_22
      pnpm
      
      # Linters & Formatters
      prettier
      eslint
      
      # Debuggers
      vscode-js-debug
    ];
  };
}
