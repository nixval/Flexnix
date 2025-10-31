/*
 * File: lib/apps.nix
 *
 * Description:
 * Defines user-friendly wrapper scripts ('dry-switch', 'switch-home')
 * for the flake's 'apps' output.
 *
 * This function takes 'pkgs' as an argument.
 */
# { pkgs }:
#
# {
#   dry-switch = {
#     type = "app";
#     program = builtins.toString (pkgs.writeShellScript "dry-switch" ''
#       # This script provides a 'dry-run' build
#       set -e
#       configName=$1
#       if [[ -z "$configName" ]]; then
#         echo "Error: Please specify which config to build." >&2
#         echo "Usage: nix run .#dry-switch -- <configName>" >&2
#         exit 1
#       fi
#       echo "Running home-manager dry-switch for: $configName"
#       ${pkgs.home-manager}/bin/home-manager switch --flake .#$configName --dry-run
#     '');
#   };
#
#   switch-home = {
#     type = "app";
#     program = builtins.toString (pkgs.writeShellScript "switch-home" ''
#       # This script builds and activates the configuration
#       set -e
#       configName=$1
#       if [[ -z "$configName" ]]; then
#         echo "Error: Please specify which config to build." >&2
#         echo "Usage: nix run .#switch-home -- <configName>" >&2
#         exit 1
#       fi
#       echo "Building & activating: $configName"
#       ${pkgs.home-manager}/bin/home-manager switch --flake .#$configName
#     '');
#   };
# }

/*
 * File: lib/apps.nix
 *
 * Description:
 * Defines user-friendly wrapper scripts that are OS-aware.
 * - 'switch-home': Alias for 'switch-user' (non-NixOS).
 * - 'switch-system': Alias for 'switch-user' (NixOS).
 * - 'switch-user': The "smart" script that detects the OS.
 */
{ pkgs }:

let
  # This is the "smart" script
  switch-user = pkgs.writeShellScript "switch-user" ''
    # This script auto-detects if it's on NixOS or not
    set -e
    configName=$1
    if [[ -z "$configName" ]]; then
      echo "Error: Please specify which config to build." >&2
      echo "Usage: nix run .#switch-user -- <configName>" >&2
      exit 1
    fi

    # Check if we are on NixOS
    if [ -f /etc/NIXOS ]; then
      echo "NixOS detected. Building system: $configName"
      # Use 'nixos-rebuild'
      # Note: This requires 'sudo' or 'nix-sudo' to be configured
      sudo nixos-rebuild switch --flake .#$configName
    else
      echo "Non-NixOS detected. Building Home Manager user: $configName"
      # Use 'home-manager'
      ${pkgs.home-manager}/bin/home-manager switch --flake .#$configName
    fi
  '';

  # This is the "smart" dry-run script
  dry-run = pkgs.writeShellScript "dry-run" ''
    set -e
    configName=$1
    if [[ -z "$configName" ]]; then
      echo "Error: Please specify which config to build." >&2
      echo "Usage: nix run .#dry-run -- <configName>" >&2
      exit 1
    fi

    if [ -f /etc/NIXOS ]; then
      echo "NixOS detected. Dry-building system: $configName"
      # Use 'nixos-rebuild dry-build'
      nixos-rebuild dry-build --flake .#$configName
    else
      echo "Non-NixOS detected. Dry-building Home Manager user: $configName"
      # Use 'home-manager build' or 'switch --dry-run'
      ${pkgs.home-manager}/bin/home-manager switch --flake .#$configName --dry-run
    fi
  '';

in
{
  # The "smart" commands
  switch-user = { type = "app"; program = builtins.toString switch-user; };
  "dry-run" = { type = "app"; program = builtins.toString dry-run; };

  # Aliases for clarity
  switch-home = { type = "app"; program = builtins.toString switch-user; };
  switch-system = { type = "app"; program = builtins.toString switch-user; };
  dry-switch = { type = "app"; program = builtins.toString dry-run; };
}
