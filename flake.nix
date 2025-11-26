{
  description = "FlexNix 2.0 — Portable & Modular Nix Configuration";

  inputs = {
    # --- Official Sources ---
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nixpkgs-stable.url = "github:NixOS/nixpkgs/nixos-25.05";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # --- Community Tools ---
    nix-flatpak.url = "github:gmodena/nix-flatpak";
    nixGL.url = "github:nix-community/nixGL";
    nvf.url = "github:NotAShelf/nvf";
    stylix.url = "github:danth/stylix";
    agenix.url = "github:ryantm/age-nix";
    nur.url = "github:nix-community/NUR";
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs:
    let
      systems = [ "x86_64-linux" "aarch64-linux" ];
      forAllSystems = nixpkgs.lib.genAttrs systems;

      # Overlay for hybrid stable/unstable packages
      overlayStable = final: prev: {
        stable = import inputs.nixpkgs-stable {
          system = prev.system;
          config.allowUnfree = true;
        };
      };

      globalOverlays = [ overlayStable ];

    in {
      formatter = forAllSystems (system: nixpkgs.legacyPackages.${system}.nixfmt);
      
      devShells = forAllSystems (system: {
        default = nixpkgs.legacyPackages.${system}.mkShell {
          buildInputs = with nixpkgs.legacyPackages.${system}; [ deadnix statix nil ];
        };
      });

      # ====================================================
      # HOME MANAGER CONFIGURATIONS
      # ====================================================
      homeConfigurations = {
        
        # 1. Maintainer Setup (liyan@debian)
        "nixval" = let
          system = "x86_64-linux";
          pkgs = import nixpkgs {
            inherit system;
            overlays = globalOverlays;
            config.allowUnfree = true;
          };
        in home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          
          # Inject Maintainer Identity
          extraSpecialArgs = { 
            inherit inputs;
            username = "nixval";
            hostname = "debian";
          };
          
          modules = [ ./hosts/debian/home.nix ];
        };

        # 2. Default Template (theName@theHost)
        "standard" = let
          system = "x86_64-linux";
          pkgs = import nixpkgs {
            inherit system;
            overlays = globalOverlays;
            config.allowUnfree = true;
          };
        in home-manager.lib.homeManagerConfiguration {
          inherit pkgs;

          # Inject Template Placeholders
          extraSpecialArgs = { 
            inherit inputs;
            username = "theName";
            hostname = "theHost";
          };
          
          modules = [ ./hosts/standard/home.nix ];
        };
      };
    };
}
