# modules/editors/neovim/ui.nix
{ ... }:

{
  programs.nvf.settings = {
    # ----------------------------------------------------
    # Tema
    # ----------------------------------------------------
    vim.theme = {
      enable = true;
      name = "catppuccin";
      style = "mocha";
      transparent = true;
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
