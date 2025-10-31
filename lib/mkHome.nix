inputs @ { nixpkgs, home-manager, nur, ... }:
{ username, hostname, system, userConfig }:

let
  inherit (nixpkgs) lib;
  stable-overlay = final: prev: {
    stable = import inputs.nixpkgs-stable {
      inherit (prev) system;
      config = prev.config;
    };
  };
  pkgs = import nixpkgs {
    inherit system;
    overlays = [ stable-overlay ]; 
    config.allowUnfree = userConfig.allowUnfree or false;
  };
in
home-manager.lib.homeManagerConfiguration {
  inherit pkgs;
  extraSpecialArgs = { 
    inherit inputs username hostname system userConfig pkgs; 
    nixgl = inputs.nixGL;
    inherit nur;
  };
  modules = lib.flatten [
    # Base modules (always enabled)
    ../home/modules/base.nix
    
    # Toggleable modules
    # cli
    (lib.optional userConfig.enableZsh ../home/modules/cli/zsh/default.nix)
    (lib.optional userConfig.enableYazi ../home/modules/cli/yazi/default.nix)
    (lib.optional userConfig.enableTmux ../home/modules/cli/tmux/default.nix)
    # editors
    (lib.optional userConfig.enableNvf ../home/modules/editors/nvf/default.nix)
    (lib.optional userConfig.enableVscode ../home/modules/editors/vscode/default.nix)
    # services
    (lib.optional userConfig.enableFlatpak ../home/modules/services/flatpak.nix)
    (lib.optional userConfig.enableSecrets ../home/modules/services/secrets.nix)
    (lib.optional userConfig.enableCachix ../home/modules/services/cachix.nix)
    # desktop
    (lib.optional userConfig.enableStylix ../home/modules/desktop/stylix.nix)
    (lib.optional userConfig.enableKitty ../home/modules/desktop/kitty.nix)
    # development
    (lib.optional userConfig.enableDevelopment ../home/modules/development/default.nix)
  ];
}
