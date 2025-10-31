/*
 * File: lib/mkHomeMatrix.nix
 * (Formerly lib/mkMatrix.nix)
 *
 * Description:
 * This "engine" builds ONLY the 'homeConfigurations' (type = "home")
 * from the matrix.nix file.
 *
 * It should NOT be edited by a cloner.
 */
{ inputs, homeBuilder, lib }:

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

# --- PERUBAHAN UTAMA DIMULAI DI SINI ---
# 1. Filter matrixConfig untuk HANYA 'type = "home"'
let
  homeMatrix = lib.filterAttrs (
    outputName: cfg: cfg.type == "home"
  ) matrixConfig;
in
# 2. Bangun HANYA 'homeMatrix' yang sudah difilter
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
    in
    # Panggil 'homeBuilder' (lib/mkHome.nix)
    homeBuilder {
      system = hostConfig.system;
      userConfig = profileConfig;
      inherit username;
      inherit hostname;
    }
) homeMatrix # <- Membangun dari 'homeMatrix' yang sudah difilter
# --- AKHIR PERUBAHAN ---

# /*
#  * File: lib/mkMatrix.nix
#  *
#  * Description:
#  * This is the "engine" that builds the homeConfigurations matrix.
#  * It should NOT be edited by a cloner.
#  *
#  * It reads all files from ./hosts and ./profiles,
#  * then uses matrix.nix to assemble them.
#  */
# { inputs, homeBuilder, lib }:
#
# let
#   # Helper function to load all .nix files from a directory
#   # It returns an attrset: { fileName = import ./path/fileName.nix; }
#   loadModulesFromDir = path:
#     let
#       # Read directory contents: { "file.nix" = "regular"; ... }
#       files = builtins.readDir path;
#       # Filter for .nix files
#       nixFiles = lib.filterAttrs (
#         name: type: type == "regular" && lib.hasSuffix ".nix" name
#       ) files;
#     in
#     # Map them to: { fileNameWithoutSuffix = import ./path/fileName.nix; }
#     lib.mapAttrs' (
#       fileName: _:
#         let
#           name = lib.removeSuffix ".nix" fileName;
#           value = import (path + "/${fileName}");
#         in
#         # 'nameValuePair' creates an attrset entry
#         lib.nameValuePair name value
#     ) nixFiles;
#
#   # 1. Load ALL available hosts and profiles
#   allHosts = loadModulesFromDir ../hosts;
#   allProfiles = loadModulesFromDir ../profiles;
#
# in
# # This is the main function that flake.nix will call.
# # It expects the attrset from matrix.nix as its argument.
# matrixConfig:
#
# lib.mapAttrs (
#   # outputName: e.g., "nixval-laptop-coding"
#   outputName:
#   # cfg: e.g., { host = "valiM", profile = "coding", username = "nixval" }
#   cfg:
#     let
#       # 2. Look up the configs from our loaded sets
#       hostConfig = allHosts.${cfg.host} or (
#         throw "Matrix Error: Host '${cfg.host}' defined in matrix.nix not found in ./hosts"
#       );
#       profileConfig = allProfiles.${cfg.profile} or (
#         throw "Matrix Error: Profile '${cfg.profile}' defined in matrix.nix not found in ./profiles"
#       );
#
#       # 3. Determine username
#       username = cfg.username or (
#         throw "Matrix Error: Assembly '${outputName}' in matrix.nix is missing 'username'."
#       );
#
#       # 4. Determine hostname
#       hostname = cfg.hostname or outputName;
#     in
#     # 5. Build the configuration using the original builder from lib/mkHome.nix
#     homeBuilder {
#       system = hostConfig.system;
#       userConfig = profileConfig; # Pass the full profile toggles
#       inherit username;
#       inherit hostname;
#     }
# ) matrixConfig
