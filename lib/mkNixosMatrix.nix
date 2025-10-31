/*
 * File: lib/mkNixOSMatrix.nix
 *
 * Description:
 * This "engine" builds ONLY the 'nixosConfigurations' (type = "nixos")
 * from the matrix.nix file.
 *
 * It should NOT be edited by a cloner.
 */
# Perhatikan: 'nixosBuilder' menggantikan 'homeBuilder' di sini
{ inputs, nixosBuilder, lib }:

let
  # ... (Fungsi 'loadModulesFromDir' tetap sama persis)
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

  allHosts = loadModulesFromDir ../hosts;
  allProfiles = loadModulesFromDir ../profiles;

in
matrixConfig: # Ini adalah isi dari matrix.nix

# 1. Filter matrixConfig untuk HANYA 'type = "nixos"'
let
  nixosMatrix = lib.filterAttrs (
    outputName: cfg: cfg.type == "nixos"
  ) matrixConfig;
in
# 2. Bangun HANYA 'nixosMatrix' yang sudah difilter
lib.mapAttrs (
  outputName:
  cfg:
    let
      hostConfig = allHosts.${cfg.host} or (
        throw "Matrix Error: Host '${cfg.host}' defined in matrix.nix not found in ./hosts"
      );
      profileConfig = allProfiles.${cfg.profile} or (
        throw "Matrix Error: Profile '${cfg.profile}' defined in matrix.nix not found in ./profiles"
      );
      username = cfg.username or (
        throw "Matrix Error: Assembly '${outputName}' in matrix.nix is missing 'username'."
      );
      hostname = cfg.hostname or outputName;
      
      # Ambil systemConfig spesifik NixOS
      systemConfig = cfg.systemConfig or (
        throw "Matrix Error: NixOS Assembly '${outputName}' is missing 'systemConfig'."
      );
    in
    # Panggil 'nixosBuilder' (lib/mkNixOS.nix)
    nixosBuilder {
      system = hostConfig.system;
      userConfig = profileConfig; # Ini adalah profile (e.g., profiles/gaming.nix)
      inherit username;
      inherit hostname;
      inherit systemConfig; # Ini adalah base system (e.g., nixos/nixval-pc.nix)
    }
) nixosMatrix # <- Membangun dari 'nixosMatrix' yang sudah difilter
