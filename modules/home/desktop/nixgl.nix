{ config, lib, pkgs, inputs, ... }:

let
  cfg = config.flexnix.modules.desktop.nixgl;
  # Dapatkan arsitektur sistem (x86_64-linux, dll) dari pkgs
  system = pkgs.system; 
in
{
  options.flexnix.modules.desktop.nixgl = {
    enable = lib.mkEnableOption "NixGL wrapper setup for OpenGL apps (Kitty, etc.)";
  };

  config = lib.mkIf cfg.enable {
    # 1. Konfigurasi NixGL
    # Mengambil paket nixGL yang sesuai dengan sistem dari flake inputs
    nixGL.packages = inputs.nixGL.packages.${system};
    
    # Default ke Mesa (AMD/Intel). 
    # TODO: Buat opsi agar user bisa ganti ke 'nvidia' via options flexnix
    nixGL.defaultWrapper = "mesa";
    nixGL.installScripts = [ "mesa" ];

    # 2. Install Paket yang dibungkus NixGL
    home.packages = [
      # Wrap Kitty dengan library GL agar bisa jalan di Ubuntu/Debian
      # (config.lib.nixGL.wrap pkgs.kitty)
      
      # (Future: Tambahkan Alacritty/Wezterm di sini)
    ];

    # # 3. Konfigurasi Kitty (Minimal)
    # programs.kitty = {
    #   enable = true;
    #   # Pengaturan font/tema diserahkan ke Stylix nanti
    #   settings = {
    #     window_padding_width = 4;
    #   };
    # };
  };
}
