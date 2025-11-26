# modules/editors/neovim/session.nix
{ ... }:

{
  programs.nvf.settings = {
    # ----------------------------------------------------
    # Session Management
    # ----------------------------------------------------
    vim.session.nvim-session-manager = {
      enable = true;
      
      # Otomatis simpan sesi terakhir saat keluar
      setupOpts.autosave_last_session = true;
      
      # Otomatis muat sesi terakhir saat nvim dimulai
      # (Ini adalah "persistence" yang Anda inginkan)
      setupOpts.autoload_mode = "LastSession";
    };
  };
}
