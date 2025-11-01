/*
 * File: home/modules/desktop/hyprland-hm.nix
 *
 * Description:
 * Manages Home Manager dotfiles and user packages for Hyprland.
 * This is loaded in *both* NixOS and non-NixOS modes.
 */
{ pkgs, ... }:

{
  # Add user packages needed for Hyprland
  home.packages = with pkgs; [
    waybar
    wofi
    hyprland-protocols
    # ... etc
  ];

  # Link dotfiles
  home.file.".config/hypr/hyprland.conf".text = ''
    # Minimal Hyprland config stub
    monitor=,preferred,auto,1
  '';

  home.file.".config/waybar/config".text = ''
    // Waybar config stub
  '';

  # ... etc for wofi, foot, ...
}
