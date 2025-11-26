{ pkgs, ... }:

{
  config = {
    # --- Home Manager Core ---
    programs.home-manager.enable = true;

    # --- Essential Packages ---
    home.packages = with pkgs; [
      zip unzip p7zip wget curl
      ripgrep fd eza bat jq
      bottom gdu
      nerd-fonts.jetbrains-mono
      neovim
    ];

    # --- Nix Configuration ---
    nixpkgs.config.allowUnfree = true;
  };
}
