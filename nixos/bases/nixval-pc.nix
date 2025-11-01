/*
 * File: nixos/nixval-pc.nix
 *
 * Description:
 * This defines the system-level configuration for the 'pc' host.
 * It handles filesystems, bootloader, hardware, and system services.
 *
 * It does NOT define users or home-manager; that will be
 * injected dynamically by the flake.
 */
{ inputs, system, ... }:

{
  # Import hardware-specific settings
  # This is why we kept the 'nixos-hardware' input
  imports = [
    inputs.nixos-hardware.nixosModules.common-cpu-amd
    inputs.nixos-hardware.nixosModules.common-gpu-amd
    # (Add your specific hardware here later)
  ];

  # Bootloader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Networking
  networking.hostName = "vali-pc"; # Will be overridden by the Matrix
  networking.networkmanager.enable = true;

  # TODO: Define your filesystems
  # fileSystems."/" = { ... };

  # Enable basic desktop services
  services.xserver.enable = true;
  services.xserver.displayManager.gdm.enable = true; # Example
  services.xserver.desktopManager.gnome.enable = true; # Example

  # Enable OpenGL
  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
  };
  
  # TODO: Enable impermanence (optional)
  # imports = [ inputs.impermanence.nixosModules.impermanence ];
  # environment.persistence."/persist" = { ... };

  # Nix settings
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  
  # System-level packages
  environment.systemPackages = [
    # (packages needed system-wide, e.g., git)
  ];
  
  # This configuration assumes 'system' is passed correctly
  system.stateVersion = "25.05";
}
