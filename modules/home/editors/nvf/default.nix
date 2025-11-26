{ config, lib, inputs, ... }:

let
  cfg = config.flexnix.modules.editors.nvf;
in
{
  imports = [
    # Import the upstream NVF module from inputs
    inputs.nvf.homeManagerModules.default

    # Import your split configuration files
    # These defines 'programs.nvf.settings' but won't activate unless enabled below
    ./core.nix
    ./debugger.nix
    ./keymaps.nix
    ./lsp.nix
    ./plugins.nix
    ./session.nix
    ./terminal.nix
    ./ui.nix
  ];

  options.flexnix.modules.editors.nvf = {
    enable = lib.mkEnableOption "Neovim (NVF) setup";
  };

  config = lib.mkIf cfg.enable {
    programs.nvf = {
      enable = true;
      enableManpages = true;
      # settings are loaded from the imported files above
    };
  };
}
