/*
 * File: home/modules/services/flatpak.nix
 *
 * Description:
 * This module *only* enables the Flatpak service.
 * It does NOT list any packages. Other modules are
 * responsible for injecting their own Flatpak dependencies.
 */
{ inputs, ... }:

{
  # 1. Import the nix-flatpak module
  # This creates the 'services.flatpak' options
  imports = [
    inputs.nix-flatpak.homeManagerModules.nix-flatpak
  ];

  # 2. Enable the service
  services.flatpak = {
    enable = true;

    # (Recommended) Automatically update on activation
    update.onActivation = true;
    
    # 3. Packages list is *intentionally* left empty.
    # Other modules will merge their packages into this list.
  };
}
