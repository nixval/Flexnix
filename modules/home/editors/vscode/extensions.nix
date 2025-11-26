# File: ~/dotfiles/nix/modules/editors/vscode/extensions.nix
{ pkgs }:

with pkgs.vscode-extensions; [
  # --- AI / Agen ---
  github.copilot
  saoudrizwan.claude-dev 
  # RooVeterinaryInc.roo-cline
  # --- WAJIB (Git & Docker) ---
  eamodio.gitlens
  ms-azuretools.vscode-docker

  # --- QOL (Kualitas Hidup) ---
  jnoortheen.nix-ide
  dracula-theme.theme-dracula
  vscode-icons-team.vscode-icons
  ms-vscode-remote.remote-ssh

  # --- JS / Web Stack (Heavy) ---
  astro-build.astro-vscode
  bradlc.vscode-tailwindcss
  esbenp.prettier-vscode
  dbaeumer.vscode-eslint

  # --- Small Stack (Go, Rust, Python, Lua) ---
  golang.go
  rust-lang.rust-analyzer
  ms-python.python
  sumneko.lua
  # ❌ DIHAPUS: johnnymorganz.stylua (sesuai permintaan)

  # --- Small Stack (Data & API) ---
  # mongodb.mongodb-vscode # (Saya nonaktifkan karena Anda tidak mengonfirmasi)
  humao.rest-client
]
