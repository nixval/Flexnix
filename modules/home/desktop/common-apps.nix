{ lib, config, pkgs, ... }:

let
  cfg = config.flexnix.modules.desktop.commonApps;
in
{
  options.flexnix.modules.desktop.commonApps = {
    enable = lib.mkEnableOption "Common GUI applications (Spotify, Discord, etc.)";
  };

  config = lib.mkIf cfg.enable {
    # 1. Native Packages (Nixpkgs)
    home.packages = with pkgs; [
      obsidian
      # firefox
      floorp-bin
      # vlc
      # gimp
    ];

    # 2. Flatpak Injections
    # Requires 'services.flatpak.enable = true' to work
    services.flatpak.packages = [
      "com.spotify.Client"
      # "com.discordapp.Discord"
      # "io.freetubeapp.FreeTube"
      # "org.mozilla.Thunderbird"
    ];
  };
}
