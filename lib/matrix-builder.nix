/*
 * File: lib/matrix-builder.nix
 *
 * Description:
 * The single, unified "Matrix Engine".
 * It reads matrix.nix and filters it based on the
 * build type ("home" or "nixos") passed by flake.nix.
 *
 * This file should NOT be edited by a cloner.
 */
{ inputs, lib, homeBuilder, nixosBuilder }:

# This is a function that returns the *actual* builder function
let
  # --- Helper (copied from old matrix files) ---
  # Loads all .nix files from a given path
  loadModulesFromDir = path:
    let
      files = builtins.readDir path;
      nixFiles = lib.filterAttrs (
        name: type: type == "regular" && lib.hasSuffix ".nix" name
      ) files;
    in
    lib.mapAttrs' (
      fileName: _:
        let
          name = lib.removeSuffix ".nix" fileName;
          value = import (path + "/${fileName}");
        in
        lib.nameValuePair name value
    ) nixFiles;

  # --- Load all definitions ONCE ---
  matrixConfig = import ../matrix.nix;
  allHosts = loadModulesFromDir ../hosts;
  allProfiles = loadModulesFromDir ../profiles;

in
# This is the function flake.nix calls (e.g., matrixBuilder "home")
(buildType: # buildType is either "home" or "nixos"
  let
    # 1. Filter the matrix based on the requested type
    filteredMatrix = lib.filterAttrs (
      outputName: cfg: cfg.type == buildType
    ) matrixConfig;
  in
  # 2. Build only the filtered list
  lib.mapAttrs (
    outputName: cfg:
      let
        # 3. Get all shared data
        hostConfig = allHosts.${cfg.host} or (throw "...");
        profileConfig = allProfiles.${cfg.profile} or (throw "...");
        username = cfg.username or (throw "...");
        hostname = cfg.hostname or outputName;
        system = hostConfig.system;
      in
      # 4. Call the correct "Cook" (Builder)
      if buildType == "home" then
        homeBuilder {
          # Args for lib/hm-builder.nix
          inherit system userConfig username hostname;
        }
      else # buildType == "nixos"
        nixosBuilder {
          # Args for lib/nixos-builder.nix
          inherit system userConfig username hostname;
          systemConfig = cfg.systemConfig or (throw "...");
        }
  ) filteredMatrix
)
