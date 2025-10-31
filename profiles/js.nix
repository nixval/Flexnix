/*
 * File: profiles/js.nix
 *
 * Description:
 * Lightweight profile for JavaScript/Node.js backend work.
 */
{
  allowUnfree = true;

  # Toggles dari studi kasus
  enableDevelopment = true; # Modul ini sudah ada

  # Toggles dasar
  enableZsh = true;
  enableCachix = true;
  enableSecrets = true;
  enableNvf = true; # Asumsi untuk coding

  # ... (non-aktifkan sisanya)
  enableKitty = false; # Mungkin tidak perlu di server
  enableYazi = false;
  enableTmux = false;
  enableVscode = false;
  enableFlatpak = false;
  enableStylix = false;
}
