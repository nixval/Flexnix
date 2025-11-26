{ config, lib, pkgs, ... }:

let
  cfg = config.flexnix.modules.development.android;
in
{
  options.flexnix.modules.development.android = {
    enable = lib.mkEnableOption "Android development suite";
  };

  config = lib.mkIf cfg.enable {
    # 1. Command Line Tools
    home.packages = with pkgs; [
      android-tools # adb, fastboot
    ];

    # 2. Android Studio (Flatpak)
    # Only active if flatpak service is also enabled
    services.flatpak.packages = [
      "com.google.AndroidStudio"
    ];
  };
}
