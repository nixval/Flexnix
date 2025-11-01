/*
 * File: home/modules/desktop/kitty.nix
 *
 * Description:
 * Configures 'kitty' terminal using the 'extraSpecialArgs'
 * 'nixgl' integration.
 *
 * This version uses the modern 'packages' output to
 * fix the 'mesa.drivers' deprecation warning.
 */
# 1. --- HEADER UPDATED ---
# We add 'system' (which is already in extraSpecialArgs)
# to access the correct package set.
{ config, lib, pkgs, nixgl, system, ... }:

{
  # 2. --- THE FIX ---
  # Instead of the deprecated 'import nixgl', we
  # access the flake's 'packages' output directly.
  nixGL.packages = nixgl.packages.${system};

  # 3. The rest of your (working) config
  # We still set these options for Home Manager's built-in lib
  nixGL.defaultWrapper = "mesa";
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
  #   # ... etc
  # };
}

# { config, lib, pkgs, nixgl, ... }: # Receives 'nixgl' via extraSpecialArgs
#
# {
#   nixGL.packages = import nixgl { inherit pkgs; };
#   nixGL.defaultWrapper = "mesa";
#   nixGL.installScripts = [ "mesa" ];
#   home.packages = [
#     (config.lib.nixGL.wrap pkgs.kitty)
#   ];
#
#   # 5. Optional: Configure kitty itself
#   # programs.kitty = {
#   #   enable = true;
#   #   font.name = "JetBrainsMono Nerd Font";
#   #   font.size = 14;
#   # };
# }
