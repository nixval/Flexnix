# File: ~/dotfiles/nix/modules/editors/vscode/settings.nix
{
  # --- Tampilan & Editor ---
  "workbench.iconTheme" = "vscode-icons";
  "workbench.colorTheme" = "Dracula";
  "workbench.startupEditor" = "none";
  "editor.fontFamily" = "'JetBrainsMonoNL Nerd Font', 'monospace'";
  "editor.fontSize" = 14;
  "editor.minimap.enabled" = false;
  "files.autoSave" = "onFocusChange";

  # --- Git ---
  "git.enableSmartCommit" = true;
  "git.autofetch" = true;

  # --- Terminal ---
  "terminal.integrated.fontFamily" = "'JetBrainsMonoNL Nerd Font'";

  # --- Bahasa & Formatting ---
  "editor.formatOnSave" = true;
  "editor.defaultFormatter" = "esbenp.prettier-vscode";
  
  "[javascript]" = { "editor.defaultFormatter" = "esbenp.prettier-vscode"; };
  "[javascriptreact]" = { "editor.defaultFormatter" = "esbenp.prettier-vscode"; };
  "[typescript]" = { "editor.defaultFormatter" = "esbenp.prettier-vscode"; };
  "[typescriptreact]" = { "editor.defaultFormatter" = "esbenp.prettier-vscode"; };
  "[astro]" = { "editor.defaultFormatter" = "astro-build.astro-vscode"; };
  "[nix]" = { "editor.defaultFormatter" = "jnoortheen.nix-ide"; };
  # ❌ DIHAPUS: Pengaturan [lua] (sesuai permintaan)
}
