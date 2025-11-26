{ config, lib, inputs, ... }:

let
  cfg = config.flexnix.modules.services.flatpak;
in
{
  # Import the upstream module from flake inputs
  imports = [
    inputs.nix-flatpak.homeManagerModules.nix-flatpak
  ];

  options.flexnix.modules.services.flatpak = {
    enable = lib.mkEnableOption "Declarative Flatpak management";
  };

  config = lib.mkIf cfg.enable {
    services.flatpak = {
      enable = true;
      
      # Recommended: Update flatpaks when switching generation
      update.onActivation = true;
      
      # Packages list is intentionally empty here.
      # Other modules (like gaming.nix or office.nix) will append to this list.
      packages = [ 
        "org.mozilla.Thunderbird"
      ]; 
    };
  };
}
