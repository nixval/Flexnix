/*
 * File: home/modules/desktop/kitty.nix
 *
 * Description:
 * Configures 'kitty' terminal using the official
 * Home Manager 'nixGL' integration.
 *
 * This implementation is based on Home Manager issue #114.
 */
{ config, lib, pkgs, nixgl, ... }: # Receives 'nixgl' via extraSpecialArgs

{
  # 1. Import the nixGL packages
  # (as per gerardbosch's comment)
  nixGL.packages = import nixgl { inherit pkgs; };

  # 2. Set the default wrapper
  # 'mesa' is a safe default for non-Nvidia.
  # If you have Nvidia, you might need 'nvidia'.
  nixGL.defaultWrapper = "mesa";

  # 3. Install the scripts required by the wrapper
  nixGL.installScripts = [ "mesa" ];

  # 4. Install kitty, wrapped using the *official* lib function
  home.packages = [
    (config.lib.nixGL.wrap pkgs.kitty)
  ];

  # 5. Optional: Configure kitty itself
  # programs.kitty = {
  #   enable = true;
  #   font.name = "JetBrainsMono Nerd Font";
  #   font.size = 14;
  # };
}
