# File: ~/dotfiles/nix/modules/tools/yazi/default.nix
{ pkgs, ... }:

let
  settings = import ./settings.nix;
  keymap = import ./keymap.nix;
in
{
  # 1. Tambahkan 'yazi' dan dependensi preview/plugin
  home.packages = with pkgs; [
    yazi
    ffmpegthumbnailer # Preview video
    unzip             # Preview .zip
    poppler-utils     # Preview PDF
    ueberzugpp        # Preview gambar
    ouch              # // BARU: Untuk plugin 'ouch.yazi'
  ];

  # 2. Konfigurasi modul 'yazi'
  programs.yazi = {
    enable = true;

    # --- Fitur "Powerfull" (dari wiki Anda) ---
    enableZshIntegration = true; # Aktifkan 'y' untuk cd
    shellWrapperName = "y";      # Panggil dengan 'y'

    # --- Impor Konfigurasi ---
    settings = settings;
    keymap = keymap;

    # --- Plugin "Cantik" & "Powerfull" (dari 'nix search' Anda) ---
    plugins = with pkgs.yaziPlugins; {
      # "Cantik"
      "full-border" = full-border;
      "starship" = starship;

      # "Powerfull" (Fungsional)
      "toggle-pane" = toggle-pane;
      "chmod" = chmod;
      "git" = git;
      "lazygit" = lazygit;
      "ouch" = ouch;
      "sudo" = sudo;
    };

    # --- Memuat Plugin Lua (dari wiki Anda) ---
    initLua = ''
      require("full-border"):setup()
      require("starship"):setup()
    '';
  };
}
