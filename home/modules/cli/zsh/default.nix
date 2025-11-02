{ pkgs, ... }:

{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    oh-my-zsh = {
      enable = true;
      plugins = [ "git" "sudo" ];
    };

    shellAliases = {
      cat = "bat --paging=never";
      ff = "fastfetch -c $HOME/.config/fastfetch/config.jsonc";
      st = "kitty --class special_term";
      ls = "eza --icons";
      l  = "eza -l --icons";
      la = "eza -la --icons";
      lt = "eza --tree --level=2 --icons";
      zshrc = "nvim ~/.zshrc";
      gozsh = "source ~/.zshrc";
      conf = "cd ~/.config";
      hypr = "cd ~/.config/hypr";
      cdwaybar = "cd ~/.config/waybar";
      arch = "distrobox enter dev-box";
    };

    history = {
      size = 10000;
      path = "$HOME/.zsh_history";
      share = true;
    };

    initContent = ''
      # Custom helper
      mkcd () { mkdir -p "$@" && cd "$_"; }
      export BAT_THEME="base16"
      # Initialize oh-my-posh using runtime $HOME path (avoid Nix evaluation recursion)
      if command -v oh-my-posh >/dev/null 2>&1; then
        eval "$(oh-my-posh init zsh --config $HOME/.config/oh-my-posh/theme.omp.json)"
      else
        echo "⚠️ oh-my-posh not found in PATH"
      fi

      # Load per-user env if present
      if [ -f "$HOME/.keyenv" ]; then
        source "$HOME/.keyenv"
      fi
    '';
  };

  # CLI integrations
  programs.fzf = { enable = true; enableZshIntegration = true; };
  programs.zoxide = { enable = true; enableZshIntegration = true; };
  programs.eza = { enable = true; enableZshIntegration = true; };
  programs.yazi = { enable = true; enableZshIntegration = true; };
  programs.bat.enable = true;

  # Packages needed for the shell setup
  home.packages = with pkgs; [
    oh-my-posh 
  ];

  # Ensure a predictable PATH for common local bins (still runtime strings)
  home.sessionPath = [
    "$HOME/.cargo/bin"
    "$HOME/.local/bin"
    "$HOME/.local/share/pnpm"
    "$HOME/go/bin"
  ];

  # Declare the theme file at runtime path so initExtra can use it
  home.file.".config/oh-my-posh/theme.omp.json".source = ./theme.omp.json;
}

