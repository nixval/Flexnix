{ config, pkgs, username, ... }:

{
  home.username = username;
  home.homeDirectory = "/home/${username}";
  home.stateVersion = "25.05"; # Pin state for compatibility
  home.packages = with pkgs; [
    # cli
    git tree gdu bottom xclip
    
    # advanced-cli
    fastfetch zoxide bat fzf eza
    lazygit ripgrep pnpm

    # vscode-js-debug
    # basic
    nerd-fonts.jetbrains-mono
    wget curl unzip p7zip jq 

    # system
    # pnpm

    # utility
    # nixpkgs-fmt stylua
    xclip #for x11, use wl-clipboard for wayland 
  ];
}
