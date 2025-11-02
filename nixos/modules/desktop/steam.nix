/*
 * File: nixos/modules/desktop/steam.nix
 *
 * Description:
 * Manages NixOS *system-level* settings for Steam.
 * This is *only* loaded if 'type = "nixos"'.
 */
{ ... }:

{
  # 1. Enable 32-bit graphics drivers
  # This is non-negotiable for Steam on NixOS.
  hardware.opengl.enable32Bit = true;

  # 2. Enable the system-level Steam program
  # This provides the 'steam' command and runtime.
  programs.steam.enable = true;
}
