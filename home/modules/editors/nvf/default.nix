{ inputs, vars, lib, ... }:

{
  imports = [
    inputs.nvf.homeManagerModules.default
    ./core.nix
    ./lsp.nix
    ./plugins.nix
    ./ui.nix
    ./keymaps.nix
    ./terminal.nix
    ./session.nix
    ./debugger.nix
  ];
  programs.nvf = {
    enable = true;
    enableManpages = true;
    settings = {};
  };

  
}
