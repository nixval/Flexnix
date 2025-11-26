{ lib, config, ... }:

let
  cfg = config.flexnix.profiles.coding;
in
{
  options.flexnix.profiles.coding = {
    enable = lib.mkEnableOption "coding profile (editors, devtools)";
  };

  config = lib.mkIf cfg.enable {
    # Inherit minimal settings
    flexnix.profiles.minimal.enable = true;

    # --- Future Activations ---
    flexnix.modules.editors.nvf.enable = true;
    flexnix.modules.cli.tmux.enable = true;
    flexnix.modules.cli.yazi.enable = true;
    flexnix.modules.services.flatpak.enable = true;

    flexnix.modules.editors.vscode.enable = true;
    # flexnix.modules.services.stylix.enable = true;

    flexnix.modules.desktop.nixgl.enable = true;
  };
}
