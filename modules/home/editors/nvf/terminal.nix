# modules/editors/neovim/terminal.nix
{ ... }:

{
  programs.nvf.settings = {
    # ----------------------------------------------------
    # Terminal (ToggleTerm)
    # ----------------------------------------------------
    vim.terminal.toggleterm = {
      enable = true;
      
      # Aktifkan integrasi LazyGit (keymap <leader>gg)
      lazygit.enable = true;

      # Atur terminal default agar 'float' (melayang)
      setupOpts = {
        direction = "float";
      };
    };
  };
}
