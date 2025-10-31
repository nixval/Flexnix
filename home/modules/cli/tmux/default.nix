# File: ~/dotfiles/nix/modules/tools/tmux/default.nix
{ pkgs, ... }:

let
  # Impor daftar plugin dari file terpisah
  pluginList = import ./plugins.nix { inherit pkgs; };
  
  # Impor string konfigurasi dari file terpisah
  configString = import ./config.nix;
in
{
  # 1. Dependensi
  home.packages = with pkgs; [ 
    xclip # Diperlukan untuk tmux-yank
    thumbs  # ✅ FIX: Nama paket yang benar adalah 'thumbs', bukan 'tmux-thumbs'
  ];

  # 2. Konfigurasi Modul Tmux
  programs.tmux = {
    enable = true;
    clock24 = true;
    mouse = true;
    keyMode = "vi";
    prefix = "C-a";
    
    # 3. Muat Plugin dan Konfigurasi
    plugins = pluginList;
    extraConfig = configString;
  };
}
