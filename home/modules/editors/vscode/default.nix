# File: ~/dotfiles/nix/modules/editors/vscode/default.nix
{ config, lib, pkgs, ... }:

let
  # Impor daftar ekstensi dari file terpisah
  extensionsList = import ./extensions.nix { inherit pkgs; };

  # Impor pengaturan dari file terpisah
  settingsMap = import ./settings.nix;
in
{
  programs.vscode = {
    enable = true;
    package = pkgs.vscode.fhs;

    profiles.default = {
      extensions = extensionsList;
      userSettings = settingsMap;
      
      # keybindings dan snippets tidak dikelola, sesuai permintaan
    };
  };
}
