{
  description = "flexnix — portable home-manager first flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nixpkgs-stable.url = "github:NixOS/nixpkgs/nixos-25.05"; # Match stateVersion

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    flake-parts.url = "github:hercules-ci/flake-parts";
    nvf.url = "github:NotAShelf/nvf";
    agenix.url = "github:ryantm/age-nix";
    nur = { url = "github:nix-community/NUR"; inputs.nixpkgs.follows = "nixpkgs"; };
    nix-index-database.url = "github:nix-community/nix-index-database";
    nixGL.url = "github:nix-community/nixGL";
    nixos-hardware.url = "github:nixos/nixos-hardware";
    impermanence.url = "github:nix-community/impermanence";
    stylix.url = "github:danth/stylix";
    nix-flatpak.url = "github:gmodena/nix-flatpak";
  };

  outputs = inputs @ { flake-parts, ... }:
    # --- LET BLOCK (DEFINISI UTAMA) ---
    # Ditempatkan di sini, di luar 'mkFlake'
    let
      # 1. Load the cloner-friendly "assembly list"
      matrixConfig = import ./matrix.nix;
      lib = inputs.nixpkgs.lib;

      # 2. Load the "Cooks" (the individual builders)
      homeBuilder = import ./lib/mkHome.nix inputs;
      nixosBuilder = import ./lib/mkNixOS.nix inputs;

      # 3. Load the "Factory Managers" (the matrix engines)
      homeMatrixBuilder = import ./lib/mkHomeMatrix.nix {
        inherit inputs lib;
        homeBuilder = homeBuilder; # Pass the HM cook
      };
      nixosMatrixBuilder = import ./lib/mkNixOSMatrix.nix {
        inherit inputs lib;
        nixosBuilder = nixosBuilder; # Pass the NixOS cook
      };
    in
    # --- PANGGILAN FLAKE-PARTS ---
    flake-parts.lib.mkFlake { inherit inputs; } {
      # Atribut-atribut ini sekarang menggunakan variabel dari 'let' di atas
      
      systems = import ./systems.nix;

      # 1. perSystem BLOCK (Tools)
      perSystem = { system, pkgs, inputs, ... }: {
        formatter = pkgs.nixfmt;
        
        devShells.default = pkgs.mkShell {
          buildInputs = with pkgs; [ deadnix statix nil ];
        };

        checks.format = pkgs.runCommand "check-format" {} ''
          ${pkgs.nixfmt}/bin/nixfmt --check ${./.} && touch $out
        '';
        apps = import ./lib/apps.nix { inherit pkgs; };
      }; # End perSystem

      # 2. flake BLOCK (Global Outputs)
      flake = {
        # Global overlay (consumed by perSystem.pkgs)
        # overlays.default = import ./overlays/default.nix { inherit inputs; };

        # 4a. Build all Home Manager (non-NixOS) configurations
        homeConfigurations = homeMatrixBuilder matrixConfig;

        # 4b. Build all NixOS System configurations
        nixosConfigurations = nixosMatrixBuilder matrixConfig;
      }; # End flake
    };
}


# {
#   description = "flexnix — portable home-manager first flake";
#
#   inputs = {
#     nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
#     nixpkgs-stable.url = "github:NixOS/nixpkgs/nixos-25.05"; # Match stateVersion
#
#     home-manager = {
#       url = "github:nix-community/home-manager";
#       inputs.nixpkgs.follows = "nixpkgs";
#     };
#     flake-parts.url = "github:hercules-ci/flake-parts";
#     nvf.url = "github:NotAShelf/nvf";
#     agenix.url = "github:ryantm/age-nix";
#     nur = { url = "github:nix-community/NUR"; inputs.nixpkgs.follows = "nixpkgs"; };
#     nix-index-database.url = "github:nix-community/nix-index-database";
#     nixGL.url = "github:nix-community/nixGL";
#     nixos-hardware.url = "github:nixos/nixos-hardware";
#     impermanence.url = "github:nix-community/impermanence";
#     stylix.url = "github:danth/stylix";
#     nix-flatpak.url = "github:gmodena/nix-flatpak";
#   };
#
#   # 'cachix' removed from function arguments
#   outputs = inputs @ { flake-parts, ... }:
#     flake-parts.lib.mkFlake { inherit inputs; } {
#
#       # --- 'imports' and 'config' blocks removed ---
#
#       systems = import ./systems.nix;
#
#       # 1. perSystem BLOCK (Tools)
#       perSystem = { system, pkgs, inputs, ... }: {
#         formatter = pkgs.nixfmt;
#
#         devShells.default = pkgs.mkShell {
#           buildInputs = with pkgs; [ deadnix statix nil ];
#         };
#
#         checks.format = pkgs.runCommand "check-format" {} ''
#           ${pkgs.nixfmt}/bin/nixfmt --check ${./.} && touch $out
#         '';
#         apps = import ./lib/apps.nix { inherit pkgs; };
#       }; # End perSystem
#
#       # 2. flake BLOCK (Global Outputs)
#       let
#          # 1. Load the cloner-friendly "assembly list"
#          matrixConfig = import ./matrix.nix;
#          lib = inputs.nixpkgs.lib;
#
#          # 2. Load the "Cooks" (the individual builders)
#          homeBuilder = import ./lib/mkHome.nix inputs;
#          nixosBuilder = import ./lib/mkNixOS.nix inputs;
#
#          # 3. Load the "Factory Managers" (the matrix engines)
#          homeMatrixBuilder = import ./lib/mkHomeMatrix.nix {
#            inherit inputs lib;
#            homeBuilder = homeBuilder; # Pass the HM cook
#          };
#          nixosMatrixBuilder = import ./lib/mkNixOSMatrix.nix {
#            inherit inputs lib;
#            nixosBuilder = nixosBuilder; # Pass the NixOS cook
#          };
#        in
#
#        # 2. flake BLOCK (Global Outputs)
#        flake = {
#          # Global overlay (consumed by perSystem.pkgs)
#          # overlays.default = import ./overlays/default.nix { inherit inputs; };
#
#          # 4a. Build all Home Manager (non-NixOS) configurations
#          homeConfigurations = homeMatrixBuilder matrixConfig;
#
#          # 4b. Build all NixOS System configurations
#          nixosConfigurations = nixosMatrixBuilder matrixConfig;
#        }; # End flake
#      };
#        # homeConfigurations =
#        #    let
#        #      # 1. Load the original home builder
#        #      # This passes 'inputs' to lib/mkHome.nix
#        #      homeBuilder = import ./lib/mkHome.nix inputs;
#        #
#        #      # 2. Load the matrix "engine"
#        #      matrixBuilder = import ./lib/mkMatrix.nix {
#        #        inherit inputs homeBuilder;
#        #        lib = inputs.nixpkgs.lib;
#        #      };
#        #
#        #      # 3. Load the cloner-friendly "assembly list"
#        #      matrixConfig = import ./matrix.nix;
#        #    in
#        #    # 4. Build it!
#        #    matrixBuilder matrixConfig;
#       # }; # End flake
#     # };
# }
#
