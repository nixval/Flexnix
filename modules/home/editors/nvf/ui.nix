# modules/editors/neovim/ui.nix
{ lib, ... }:

{
  programs.nvf.settings = {
    # ----------------------------------------------------
    # Tema
    # ----------------------------------------------------
    vim.theme = {
      enable = true;
      name = lib.mkForce "catppuccin";
      style = "mocha";
      transparent = lib.mkForce true;
    };

    # ----------------------------------------------------
    # UI (Mirip AstroNvim)
    # ----------------------------------------------------
    vim.visuals.nvim-web-devicons.enable = true;
    vim.statusline.lualine.enable = true;
    vim.filetree.neo-tree.enable = true;
    vim.dashboard.alpha.enable = true;
  };
}
