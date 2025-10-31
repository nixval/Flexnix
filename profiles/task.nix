/*
 * File: profiles/task.nix
 *
 * Description:
 * Profile for office/admin tasks.
 */
{
  allowUnfree = true;

  # Toggles dari studi kasus
  enableLibreOffice = false; # TODO: Buat modul home/modules/desktop/office.nix
  enableSecrets = true;    # Modul ini sudah ada
  enableFlatpak = true;    # Modul ini sudah ada

  # Toggles dasar
  enableZsh = true;
  enableKitty = true;
  enableCachix = true;

  # ... (non-aktifkan sisanya)
  enableNvf = false;
  enableYazi = false;
  enableTmux = false;
  enableVscode = false;
  enableStylix = false;
  enableDevelopment = false;
}
