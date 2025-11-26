# modules/editors/neovim/debugger.nix
# Hanya perlu pkgs dan inputs sekarang
{ pkgs, inputs, ... }:

let
  dag = inputs.nvf.lib.nvim.dag;
in
{
  programs.nvf.settings = {
    # ----------------------------------------------------
    # Debug Adapter Protocol (DAP)
    # ----------------------------------------------------
    
    # Aktifkan plugin nvim-dap & UI
    vim.debugger.nvim-dap.enable = true;
    vim.debugger.nvim-dap.ui.enable = true;
    
    # Aktifkan debugger Go (bawaan nvf)
    vim.languages.go.dap.enable = true;

    # ----------------------------------------------------
    # Konfigurasi DAP Node/TS via nvim-dap-vscode-js
    # (Mengikuti contoh dari forum relief-melone)
    # ----------------------------------------------------
    vim.luaConfigRC.dapNodeSetup = dag.entryAfter [ "pluginConfigs" ] ''
      -- Panggil setup dari plugin helper nvim-dap-vscode-js
      require("dap-vscode-js").setup({
        -- Beri tahu helper di mana paket Nix vscode-js-debug berada
        debugger_path = "${pkgs.vscode-js-debug}", 
        
        -- Tentukan adapter mana yang ingin dikonfigurasi oleh helper
        adapters = { 'pwa-node' }, 
        
        -- Opsi lain bisa ditambahkan di sini jika perlu
        -- ...
      })

      -- Catatan: Plugin helper ini seharusnya sudah secara otomatis
      -- mengkonfigurasi dap.adapters['pwa-node'] dan 
      -- dap.configurations untuk javascript/typescript.
      -- Kita tidak perlu mendefinisikannya lagi secara manual.
    '';
  };
}
