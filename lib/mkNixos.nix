/*
 * File: lib/mkNixOS.nix
 *
 * Description:
 * This is the NixOS "system builder".
 * It takes a base system config (from ./nixos) and a
 * home-manager profile (from ./profiles) and glues them
 * together to build a complete, bootable NixOS system.
 *
 * It should NOT be edited by a cloner.
 */
inputs @ { nixpkgs, home-manager, nur, ... }:
# These args come from the matrix build engine
{ username, hostname, system, userConfig, systemConfig }:

let
  # --- Consistency Check ---
  # This 'let' block MUST mirror lib/mkHome.nix
  # to ensure pkgs, overlays, and specialArgs are
  # consistent between NixOS and non-NixOS builds.
  inherit (nixpkgs) lib;
  stable-overlay = final: prev: {
    stable = import inputs.nixpkgs-stable {
      inherit (prev) system;
      config = prev.config;
    };
  };

  # This 'pkgs' instance is for the *system*
  pkgs = import nixpkgs {
    inherit system;
    overlays = [ stable-overlay ];
    # Get unfree preference from the profile
    config.allowUnfree = userConfig.allowUnfree or false;
  };

  # These args are passed to *Home Manager*
  # This MUST match extraSpecialArgs in lib/mkHome.nix
  hmSpecialArgs = {
    inherit inputs username hostname system userConfig pkgs;
    nixgl = inputs.nixGL;
    inherit nur;
  };

in
# Use the official NixOS system builder
lib.nixosSystem {
  inherit system;
  
  # Pass 'inputs' to system modules (e.g., nixos/nixval-pc.nix)
  specialArgs = { inherit inputs; };

  modules = [
    # 1. Enable Home Manager at the system level
    inputs.home-manager.nixosModules.home-manager

    # 2. Import the base system configuration
    # (filesystems, hardware, etc. from ./nixos/nixval-pc.nix)
    (import ../nixos/${systemConfig})

    # 3. This is the "glue" module.
    # It dynamically injects the user and their profile
    # into the base system configuration.
    ({ ... }: {
      # Set the system's hostname from the matrix
      networking.hostName = hostname;

      # Create the user defined in the matrix
      users.users.${username} = {
        isNormalUser = true;
        description = "Main user";
        # Add sudo (wheel) and networkmanager access
        extraGroups = [ "wheel" "networkmanager" ];
        # You can set your default shell here if needed
        # shell = pkgs.zsh;
      };

      # Configure Home Manager *for that user*
      home-manager.users.${username} = {
        # This is the magic: it imports the correct profile
        # e.g., ./profiles/gaming.nix
        imports = [ userConfig ];

        # Pass the *exact same* args as the non-NixOS builder
        # to ensure the profile behaves identically.
        inherit pkgs;
        extraSpecialArgs = hmSpecialArgs;
      };
    })
  ];
}
