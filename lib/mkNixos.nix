inputs @ { nixpkgs, home-manager, nur, ... }:
{ username, hostname, system, userConfig, systemConfig }:

let
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
    inputs.home-manager.nixosModules.home-manager
    (import ../nixos/bases/${systemConfig})
    (lib.optional (userConfig.enableHyprland or false) ../nixos/modules/desktop/hyprland/hyprland.nix)
    ({ ... }: {
      networking.hostName = hostname;

      users.users.${username} = {
        isNormalUser = true;
        description = "Main user";
        extraGroups = [ "wheel" "networkmanager" ];
      };

      home-manager.users.${username} = {
        imports = (import ./mkHomeModules.nix { inherit lib; inherit userConfig; });
        inherit pkgs;
        extraSpecialArgs = hmSpecialArgs;
      };
    })
  ];
}
