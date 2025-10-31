# File: ~/dotfiles/nix/modules/tools/yazi/keymap.nix
{
  mgr.prepend_keymap = [
    # --- Plugin (dari Wiki) ---
    { 
      on = [ "T" ]; 
      run = "plugin toggle-pane max-preview";
      desc = "Maximize/restore preview";
    }
    { 
      on = [ "c" "m" ];
      run = "plugin chmod";
      desc = "Chmod";
    }

    # --- Plugin "Powerfull" Baru ---
    { on = [ "L" ]; run = "plugin lazygit"; desc = "Run Lazygit"; }
    { on = "S"; run = "plugin sudo"; desc = "Run sudo"; }

    # --- Navigasi Vim ---
    { on = [ "g" "g" ]; run = "jump_top"; desc = "Jump to top"; }
    { on = [ "G" ]; run = "jump_bottom"; desc = "Jump to bottom"; }
    
    # --- Zoxide ---
    { on = [ "z" ]; run = "jump zoxide"; desc = "Jump with zoxide"; }
    { on = [ "g" "h" ]; run = "cd ~"; desc = "Go to home"; }
  ];

  input.prepend_keymap = [
    { on = [ "<Esc>" ]; run = "close"; desc = "Cancel input"; }
  ];

  tasks.prepend_keymap = [
    { on = [ "q" ]; run = "close"; desc = "Close tasks"; }
  ];
}
