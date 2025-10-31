# modules/editors/neovim/plugins.nix
{ inputs, pkgs, lib, ... }:

let
  dag = inputs.nvf.lib.nvim.dag;
in
{
  programs.nvf.settings = {
    # ----------------------------------------------------
    # Daftar Plugin (non-nvf)
    # ----------------------------------------------------
    vim.startPlugins = [
      pkgs.vimPlugins.plenary-nvim
      pkgs.vimPlugins.mini-nvim
      pkgs.vimPlugins.telescope-nvim
      pkgs.vimPlugins.which-key-nvim
      pkgs.vimPlugins.nvim-dap-vscode-js
    ];

    # ----------------------------------------------------
    # Custom Lua (DAG)
    # ----------------------------------------------------
    vim.luaConfigRC = {
      myCustomSettings = dag.entryAfter [ "pluginConfigs" ] ''
        vim.g.my_global_setting = true
        
        -- Setup Telescope
        require('telescope').setup{}

        -- Setup Which-key
        require('which-key').setup{
          -- Konfigurasi Anda bisa ditambahkan di sini
        }
      '';
    };
  };
}
