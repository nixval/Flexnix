/*
 * File: lib/mkNixOS.nix
 * (Updated to fix HM bug and add DE/WM toggles)
 *
 * Description:
 * This is the "NixOS Cook". It builds a complete NixOS system.
 */
inputs @ { nixpkgs, home-manager, nur, ... }:
{ username, hostname, system, userConfig, systemConfig }:

let
  # --- Consistency Block ---
  # (This is identical to lib/mkHome.nix)
  inherit (nixpkgs) lib;
  stable-overlay = final: prev: {
    stable = import inputs.nixpkgs-stable {
      inherit (prev) system;
      config = prev.config;
    };
  };
  globalOverlay = import ../overlays/default.nix { inherit inputs; };
  pkgs = import nixpkgs {
    inherit system;
    overlays = [ stable-overlay globalOverlay ];
    config.allowUnfree = userConfig.allowUnfree or false;
  };
  # --- End Consistency Block ---

  # HM args (must match mkHome.nix)
  hmSpecialArgs = {
    inherit inputs username hostname system userConfig pkgs;
    nixgl = inputs.nixGL;
    inherit nur;
  };

in
lib.nixosSystem {
  inherit system;
  
  specialArgs = { inherit inputs; };

  modules = [
    # 1. Enable Home Manager at the system level
    inputs.home-manager.nixosModules.home-manager

    # 2. Import the base system configuration
    # (e.g., ./nixos/nixval-pc.nix)
    (import ../nixos/${systemConfig})

    # --- NEW: System-level DE/WM Toggles ---
    # This toggle loads the NixOS *service* for Hyprland
    (lib.optional userConfig.enableHyprland ../nixos/modules/desktop/hyprland/hyprland.nix)
    # (lib.optional userConfig.enableGnome ../nixos/modules/gnome-sys.nix)

    # 3. The "glue" module
    ({ ... }: {
      networking.hostName = hostname;

      users.users.${username} = {
        isNormalUser = true;
        description = "Main user";
        extraGroups = [ "wheel" "networkmanager" ];
      };

      home-manager.users.${username} = {
        # --- CRITICAL BUG FIX ---
        # Import the central HM "recipe book" (mkHomeModules.nix)
        # This fixes the bug where HM modules were not loading.
        imports = (import ./mkHomeModules.nix { inherit lib; inherit userConfig; });
        
        # Pass consistent pkgs and args
        inherit pkgs;
        extraSpecialArgs = hmSpecialArgs;
      };
    })
  ];
}
