{ config, lib, pkgs, ... }:

let
  cfg = config.flexnix.modules.editors.vscode;
  
  # Load external files
  extensionsList = import ./extensions.nix { inherit pkgs; };
  settingsMap = import ./settings.nix;
in
{
  options.flexnix.modules.editors.vscode = {
    enable = lib.mkEnableOption "VSCode with extensions";
  };

  config = lib.mkIf cfg.enable {
    programs.vscode = {
      enable = true;
      package = pkgs.vscode.fhs; # FHS variant for better compatibility
      
      profiles.default = {
        extensions = extensionsList;
        userSettings = settingsMap;
        # Keybindings managed manually
      };
    };
  };
}
