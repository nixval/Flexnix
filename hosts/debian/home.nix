{ config, pkgs, username, ... }:

{
  imports = [
    ../../modules/home
    ../../profiles/home
  ];

  config = {
    # --- Identity ---
    home.username = username;
    home.homeDirectory = "/home/${username}";
    home.stateVersion = "25.05";

    # --- Profile Activation ---
    # Enable full suite for testing
    flexnix.profiles.coding.enable = true;

    # --- Overrides ---
    # Specific tweaks for this machine
#    flexnix.modules.desktop.steam.enable = false;
 #   flexnix.modules.services.flatpak.enable = true;
  };
}
