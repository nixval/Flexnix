{ lib, config, ... }:

let
  cfg = config.flexnix.profiles.coding;
in
{
  options.flexnix.profiles.coding = {
    enable = lib.mkEnableOption "coding profile (editors, devtools)";
  };

  config = lib.mkIf cfg.enable {
    flexnix.profiles.minimal.enable = true;

    # Core & Editors
    flexnix.modules.editors.nvf.enable = true;
    flexnix.modules.editors.vscode.enable = true;
    flexnix.modules.cli.tmux.enable = true;
    flexnix.modules.cli.yazi.enable = true;

    # Services
    flexnix.modules.services.flatpak.enable = true;
    # flexnix.modules.services.secrets.enable = true;
    # flexnix.modules.services.cachix.enable = true;

    # Desktop
    flexnix.modules.desktop.nixgl.enable = true;
    flexnix.modules.desktop.stylix.enable = true;
    flexnix.modules.desktop.commonApps.enable = true;

    # --- Languages ---
    flexnix.modules.languages.go.enable = true;
    flexnix.modules.languages.rust.enable = true;
    flexnix.modules.languages.python.enable = true;
    flexnix.modules.languages.javascript.enable = true;
    flexnix.modules.languages.utils.enable = true;

    # --- Data ---
    flexnix.modules.development.database.enable = true; 
    
    # Android (Optional, enable if needed)
    # flexnix.modules.development.android.enable = true;  };
}
