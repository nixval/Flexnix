/*
 * File: home/modules/development/android.nix
 *
 * Description:
 * Installs Android Studio via Flatpak and other tools from Nixpkgs.
 */
{ pkgs, ... }:

{
  # 1. Install CLI tools from Nixpkgs
  home.packages = [
    pkgs.android-tools # Provides 'adb', 'fastboot'
  ];

  # 2. Inject Android Studio into the Flatpak list
  services.flatpak.packages = [
    "com.google.AndroidStudio"
  ];
}
