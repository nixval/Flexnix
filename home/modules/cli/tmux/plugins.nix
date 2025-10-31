# File: ~/dotfiles/nix/modules/tools/tmux/plugins.nix
# Daftar plugin tmux yang dikelola secara deklaratif
{ pkgs }:

with pkgs.tmuxPlugins; [
  # --- Keamanan & Sesi ---
  resurrect  # Menyimpan & memulihkan sesi setelah reboot
  continuum  # Menyimpan otomatis secara terus-menerus

  # --- Utilitas & QOL ---
  yank       # Menyalin ke clipboard sistem
  open       # Membuka file/URL dari buffer
  copycat    # Pencarian cepat di buffer
  
  # --- Navigasi & "Vim Way" ---
  vim-tmux-navigator # Navigasi mulus antara pane Vim dan Tmux
  tmux-thumbs        # "Hints" ala Vimium untuk copy/paste (Prefix + f)
  pain-control       # // BARU: Keybinds pane yang intuitif (Prefix + panah)

  # --- Manajemen & Multitasking ---
  session-wizard     # // BARU: Manajemen sesi FZF + Zoxide (Prefix + s)
  tmux-fzf           # // BARU: Popup FZF untuk beralih window/pane

  # --- Tampilan & Indikator ---
  catppuccin         # Tema Catppuccin
  prefix-highlight   # Menyorot saat prefix ditekan
  mode-indicator     # Menampilkan mode saat ini (misal: [COPY])
]
