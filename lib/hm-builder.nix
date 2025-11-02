/*
 * File: lib/mkHome.nix
 * (Updated to use the central mkHomeModules.nix)
 *
 * Description:
 * This is the "Home Manager Cook". It builds a standalone
 * home-manager configuration for non-NixOS systems.
 */
inputs @ { nixpkgs, home-manager, nur, ... }:
{ username, hostname, system, userConfig }:

let
  # --- Consistency Block ---
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
in
home-manager.lib.homeManagerConfiguration {
  inherit pkgs;
  
  # Pass special args (must match mkNixOS.nix)
  extraSpecialArgs = {
    inherit inputs username hostname system userConfig pkgs;
    nixgl = inputs.nixGL;
    inherit nur;
  };

  # --- UPDATED ---
  # This file no longer contains the logic.
  # It imports the central "recipe book" and passes
  # the required toggles (userConfig) to it.
  modules = (import ./hm-modules.nix { inherit lib; inherit userConfig; });
}
