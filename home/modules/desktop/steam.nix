/*
 * File: home/modules/desktop/steam.nix
 *
 * Description:
 * Injects the Flatpak version of Steam.
 * This is the 'flawless' solution for non-NixOS systems.
 */
{ ... }:

{
  # This module injects the Steam flatpak
  services.flatpak.packages = [
    "com.valvesoftware.Steam"
    
    # (Optional) Add ProtonUp-Qt and ProtonTricks
    # "net.davidotek.protontricks"
    # "com.github.Matoking.protontricks"
  ];

  # This toggle also requires 'enableFlatpak = true'
  # in the profile to function.
}
