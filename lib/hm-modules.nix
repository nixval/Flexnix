/*
 * File: lib/mkHomeModules.nix
 * (Updated with default values to prevent 'missing attribute' errors)
 */
{ lib, userConfig }:

let
  # Helper function to safely check a toggle
  # It returns 'false' if the attribute is missing
  get = attr: userConfig.${attr} or false;
in
lib.flatten [
  # Base modules (always enabled)
  ../home/modules/base.nix
  
  # === Toggleable modules ===
  # cli
  (lib.optional (get "enableZsh") ../home/modules/cli/zsh/default.nix)
  (lib.optional (get "enableYazi") ../home/modules/cli/yazi/default.nix)
  (lib.optional (get "enableTmux") ../home/modules/cli/tmux/default.nix)
  
  # editors
  (lib.optional (get "enableNvf") ../home/modules/editors/nvf/default.nix)
  (lib.optional (get "enableVscode") ../home/modules/editors/vscode/default.nix)
  
  # services
  (lib.optional (get "enableFlatpak") ../home/modules/services/flatpak.nix)
  (lib.optional (get "enableSecrets") ../home/modules/services/secrets.nix)
  (lib.optional (get "enableCachix") ../home/modules/services/cachix.nix)
  
  # desktop
  (lib.optional (get "enableStylix") ../home/modules/desktop/stylix/default.nix)
  (lib.optional (get "enableKitty") ../home/modules/desktop/kitty/default.nix)
  (lib.optional (get "enableCommonApps") ../home/modules/desktop/common-apps/default.nix)
  (lib.optional (get "enableSteam") ../home/modules/desktop/steam.nix)
  # --- NEW DE/WM MODULES ---
  (lib.optional (get "enableHyprland") ../home/modules/desktop/hyprland/hyprland.nix)
  # (lib.optional (get "enableGnome") ../home/modules/desktop/gnome-hm.nix)
  
  # development
  (lib.optional (get "enableDevelopment") ../home/modules/development/default.nix)
  (lib.optional (get "enableAndroid") ../home/modules/development/android.nix)
]


# /*
#  * File: lib/mkHomeModules.nix
#  *
#  * Description:
#  * This file is the "central recipe book" for Home Manager.
#  * It contains the logic to load all modular HM components
#  * based on the toggles found in a profile.
#  *
#  * It is imported by *both* mkHome.nix (for HM builds)
#  * and mkNixOS.nix (for NixOS builds) to ensure consistency.
#  */
# { lib, userConfig }: # Needs lib and the profile's toggles
#
# lib.flatten [
#   # Base modules (always enabled)
#   ../home/modules/base.nix
#
#   # === Toggleable modules ===
#   # cli
#   (lib.optional userConfig.enableZsh ../home/modules/cli/zsh/default.nix)
#   (lib.optional userConfig.enableYazi ../home/modules/cli/yazi/default.nix)
#   (lib.optional userConfig.enableTmux ../home/modules/cli/tmux/default.nix)
#
#   # editors
#   (lib.optional userConfig.enableNvf ../home/modules/editors/nvf/default.nix)
#   (lib.optional userConfig.enableVscode ../home/modules/editors/vscode/default.nix)
#
#   # services
#   (lib.optional userConfig.enableFlatpak ../home/modules/services/flatpak.nix)
#   (lib.optional userConfig.enableSecrets ../home/modules/services/secrets.nix)
#   (lib.optional userConfig.enableCachix ../home/modules/services/cachix.nix)
#
#   # desktop
#   (lib.optional userConfig.enableStylix ../home/modules/desktop/stylix.nix)
#   (lib.optional userConfig.enableKitty ../home/modules/desktop/kitty.nix)
#   (lib.optional userConfig.enableCommonApps ../home/modules/desktop/common-apps.nix)
#
#   # --- NEW DE/WM MODULES ---
#   # This toggle loads the Home Manager *dotfiles* for Hyprland
#   (lib.optional userConfig.enableHyprland ../home/modules/desktop/hyprland/hyprland.nix)
#   # (lib.optional userConfig.enableGnome ../home/modules/desktop/gnome-hm.nix)
#
#   # development
#   (lib.optional userConfig.enableDevelopment ../home/modules/development/default.nix)
#   (lib.optional userConfig.enableAndroid ../home/modules/development/android.nix)
# ]
