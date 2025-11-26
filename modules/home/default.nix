{
  imports = [
    ./base.nix
    
    # CLI
    ./cli/zsh.nix
    ./cli/tmux
    ./cli/yazi
    
    # Editors
    ./editors/nvf
    ./editors/vscode
    
    # Services
    ./services/flatpak
    # ./services/secrets.nix
    # ./services/cachix.nix
    
    # Desktop
    ./desktop/nixgl.nix
    ./desktop/stylix.nix
    ./desktop/common-apps.nix

    # Development
    ./languages
    # ./languages/rust.nix
    # ./languages/javascript.nix
    # ./languages/utils.nix
    # ./languages/python.nix
    ./development 
  ];
}
