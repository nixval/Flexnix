# File: ~/dotfiles/nix/modules/tools/tmux/config.nix
# Konfigurasi kustom (keybinds dan pengaturan plugin)
''
  # ==================================
  # === Keybindings (Vim Way)
  # ==================================
  # Panel
  bind | split-window -h -c "#{pane_current_path}"
  bind - split-window -v -c "#{pane_current_path}"
  unbind '"'
  unbind %

  # Resize panel (Repeatable)
  bind -r H resize-pane -L 5
  bind -r J resize-pane -D 5
  bind -r K resize-pane -U 5
  bind -r L resize-pane -R 5

  # Copy-mode
  bind-key -T copy-mode-vi v send-keys -X begin-selection
  bind-key -T copy-mode-vi y send-keys -X copy-selection-and-cancel

  # ==================================
  # === Pengaturan Plugin
  # ==================================

  # --- Continuum & Resurrect (Keamanan) ---
  set -g @continuum-restore 'on'
  set -g @continuum-save-interval '5'
  set -g @resurrect-capture-pane-contents 'on'
  set -g @resurrect-copy-command 'xclip -selection clipboard'

  # --- Catppuccin (Tema) ---
  set -g @catppuccin_flavour 'mocha'
  set -g @catppuccin_git_branch_text '#(git rev-parse --abbrev-ref HEAD)'

  # --- Keybinds Plugin ---
  set -g @thumbs-key 'f'
  set -g @session-wizard-key 's'

  # // BARU: Keybinds untuk tmux-fzf
  # (Prefix + w) -> FZF windows
  # (Prefix + p) -> FZF panes
  bind w run-shell -b "~/.tmux/plugins/tmux-fzf/scripts/windows.sh"
  bind p run-shell -b "~/.tmux/plugins/tmux-fzf/scripts/panes.sh"
''
