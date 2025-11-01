/*
 * File: profiles/gaming.nix
 *
 * Description:
 * Profile for gaming. Enables Steam, Flatpak, etc.
 */
{
  allowUnfree = true;
  # choose only one of this wayland compositor, no double!!
  enableHyprland = false;

  # Toggles dari studi kasus
  enableSteam = false; # TODO: Buat modul home/modules/desktop/steam.nix
  enableFlatpak = true; # Modul ini sudah ada

  # Toggles dasar (bisa di-copy dari coding.nix)
  enableZsh = true;
  enableKitty = true;
  enableCachix = true;
  enableSecrets = true; # Mungkin perlu untuk login
  
  # ... (non-aktifkan sisanya)
  enableNvf = false;
  enableYazi = false;
  enableTmux = false;
  enableVscode = false;
  enableStylix = false;
  enableDevelopment = false;
}
