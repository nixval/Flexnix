/*
 * File: home/modules/desktop/common-apps.nix
 *
 * Description:
 * Installs common GUI applications (Spotify, Discord, etc.)
 * This demonstrates injecting Flatpak packages from a module.
 */
{ ... }:

{
  # Inject packages into the Flatpak list
  services.flatpak.packages = [
    "com.spotify.Client"
    "com.discordapp.Discord"
    "io.freetubeapp.FreeTube"
    "org.mozilla.Thunderbird"
  ];
}
