/*
 * File: matrix.nix
 *
 * Description:
 * This is the central assembly matrix.
 * It defines all final homeConfigurations and nixosConfigurations.
 *
 * This is the primary file you should edit.
 *
 * Format:
 * "your-output-name" = {
 * host = "host-file-name";     # (from ./hosts)
 * profile = "profile-file-name"; # (from ./profiles)
 * username = "your-username";
 * hostname = "optional-hostname"; # (defaults to 'your-output-name')
 *
 * # --- NEW FIELDS ---
 * type = "home" | "nixos";      # "home" for non-NixOS, "nixos" for a full OS build
 * systemConfig = "file-name.nix"; # (Required if type = "nixos", must exist in ./nixos)
 * };
 */
{
  # --- Nixval's "Home Manager" (non-NixOS) Builds ---
  "nixval-laptop-coding" = {
    host = "valiM";
    profile = "coding";
    username = "nixval";
    hostname = "valiM";
    type = "home"; # This is a Home Manager build
  };

  "nixval-laptop-task" = {
    host = "valiM";
    profile = "task";
    username = "nixval";
    hostname = "valiM";
    type = "home"; # This is a Home Manager build
  };

  "nixval-server-js" = {
    host = "server";
    profile = "js";
    username = "nixval";
    hostname = "prod-server";
    type = "home"; # This is a Home Manager build
  };

  # --- Nixval's "NixOS System" Builds ---
  "nixval-pc-gaming" = {
    host = "pc";
    profile = "gaming";
    username = "nixval";
    hostname = "vali-pc";
    type = "nixos"; # This is a full NixOS build
    systemConfig = "nixval-pc.nix"; # -> loads ./nixos/nixval-pc.nix
  };

  "nixval-pc-android" = {
    host = "pc";
    profile = "android";
    username = "nixval";
    hostname = "vali-pc";
    type = "nixos"; # This is a full NixOS build
    systemConfig = "nixval-pc.nix"; # -> re-uses the same base system config
  };

  # --- Example for a Cloner "bob" (Home Manager) ---
  # "bob-mac-coding" = {
  #   host = "bobs-mac";
  #   profile = "coding";
  #   username = "bob";
  #   hostname = "bobs-mbp";
  #   type = "home";
  # };

  # --- Example for a Cloner "alice" (NixOS) ---
  # "alice-desktop-gaming" = {
  #   host = "alice-pc";
  #   profile = "gaming";
  #   username = "alice";
  #   hostname = "alice-desktop";
  #   type = "nixos";
  #   systemConfig = "alice-pc-config.nix"; # (You must create nixos/alice-pc-config.nix)
  # };
}
