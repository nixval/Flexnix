/*
 * File: home/modules/services/secrets.nix
 *
 * Description:
 * Manages all encrypted secrets using 'agenix'.
 *
 * FIX: Paths are corrected to point from this file
 * (home/modules/services/) up three levels to the root (../../../)
 * and then into the 'secrets/' directory.
 */
{ pkgs, config, inputs, ... }:

{
  # 1. Impor modul 'agenix' dari inputs
  imports = [
    inputs.agenix.homeManagerModules.default
  ];
  home.packages = with pkgs; [
    age
  ];
  # 2. Tentukan lokasi kunci privat.
  # 'agenix' akan otomatis mencarinya di sini.
  age.identityPaths = [
    "/etc/nix/age.key"
  ];

  # 3. Definisikan secrets Anda.
  #    Path 'file = ' dikoreksi dari ../../ menjadi ../../../
  age.secrets = {
    "ssh-nixvali" = {
      file = ../../../secrets/ssh-nixvali.age; # <-- DIKOREKSI
      path = "${config.home.homeDirectory}/.ssh/id_ed25519_nixvali";
      mode = "0600";
    };
    "ssh-liyankova" = {
      file = ../../../secrets/ssh-liyankova.age; # <-- DIKOREKSI
      path = "${config.home.homeDirectory}/.ssh/id_ed25519_liyankova";
      mode = "0600";
    };
    "ssh-valistudio" = {
      file = ../../../secrets/ssh-valistudio.age; # <-- DIKOREKSI
      path = "${config.home.homeDirectory}/.ssh/id_ed25519_valistudio";
      mode = "0600";
    };
  };
}
