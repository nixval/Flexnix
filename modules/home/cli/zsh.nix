{ config, lib, pkgs, ... }:

let
  cfg = config.flexnix.modules.cli.zsh;
in
{
  options.flexnix.modules.cli.zsh = {
    enable = lib.mkEnableOption "Zsh shell with Oh-My-Posh & Plugins";
  };

  config = lib.mkIf cfg.enable {
    # 1. Zsh Configuration
    programs.zsh = {
      enable = true;
      enableCompletion = true;
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;

      oh-my-zsh = {
        enable = true;
        plugins = [ "sudo" ];
      };

      shellAliases = {
        cat = "bat --paging=never";
        ff = "fastfetch"; # Simplified path for portability
        st = "kitty --class special_term";
        ls = "eza --icons";
        l  = "eza -l --icons";
        la = "eza -la --icons";
        lt = "eza --tree --level=2 --icons";
        
        # Navigation shortcuts
        conf = "cd ~/.config";
        hypr = "cd ~/.config/hypr";
        
        # Nix specific aliases could be added here later
      };

      history = {
        size = 10000;
        path = "$HOME/.zsh_history";
        share = true;
      };

      initExtra = ''
        # Custom helper function
        mkcd () { mkdir -p "$@" && cd "$_"; }
        
        # Set Bat theme
        export BAT_THEME="base16"
        
        # Initialize oh-my-posh safely
        #if command -v oh-my-posh >/dev/null 2>&1; then
        #  eval "$(oh-my-posh init zsh --config ${./theme.omp.json})"
        #fi

        # Load local env if exists
        if [ -f "$HOME/.keyenv" ]; then
          source "$HOME/.keyenv"
        fi
      '';
    };

    # 2. Shell Integrations
    programs.fzf = { enable = true; enableZshIntegration = true; };
    programs.zoxide = { enable = true; enableZshIntegration = true; };
    programs.eza = { enable = true; enableZshIntegration = true; };
    programs.bat.enable = true;
    # programs.yazi is managed in its own module, will be integrated when enabled there.

    # 3. Dependencies
    home.packages = with pkgs; [
      oh-my-posh
      fastfetch
    ];
  };
}
