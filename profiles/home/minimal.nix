{ lib, config, ... }:

let
  cfg = config.flexnix.profiles.minimal;
in
{
  options.flexnix.profiles.minimal = {
    enable = lib.mkEnableOption "minimal profile (shell & basics)";
  };

  config = lib.mkIf cfg.enable {
    # --- Future Activations ---
    flexnix.modules.cli.zsh.enable = true;
    
    # For now, it simply ensures the base is valid.
  };
}
