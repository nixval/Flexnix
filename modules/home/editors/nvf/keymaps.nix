# modules/editors/neovim/keymaps.nix
{ ... }:

{
  programs.nvf.settings = {
    # ----------------------------------------------------
    # Keymaps
    # ----------------------------------------------------
    vim.keymaps = [
      # Telescope
      { mode = "n"; key = "<leader>ff"; action = "<cmd>Telescope find_files<cr>"; desc = "Find Files"; }
      { mode = "n"; key = "<leader>fg"; action = "<cmd>Telescope live_grep<cr>"; desc = "Live Grep"; }
      { mode = "n"; key = "<leader>fb"; action = "<cmd>Telescope buffers<cr>"; desc = "Find Buffers"; }
      
      # Neo-tree
      { mode = "n"; key = "<leader>e"; action = "<cmd>Neotree toggle<cr>"; desc = "Toggle File Tree"; }

      # Terminal (BARU)
      { mode = "n"; key = "<leader>ft"; action = "<cmd>ToggleTerm direction=float<cr>"; desc = "Toggle Float Term"; }
      { mode = "n"; key = "<leader>ht"; action = "<cmd>ToggleTerm direction=horizontal<cr>"; desc = "Toggle Horiz Term"; }
      
      # Keymap <leader>gg (lazygit) diaktifkan oleh modul terminal
    ];

    # ----------------------------------------------------
    # Autocommands
    # ----------------------------------------------------
    vim.augroups = [ { name = "UserSetup"; } ];
    vim.autocmds = [
      {
        event = [ "FileType" ];
        pattern = [ "markdown" ];
        group = "UserSetup";
        desc = "Set spellcheck for Markdown";
        command = "setlocal spell";
      }
      {
        event = [ "TextYankPost" ];
        pattern = [ "*" ];
        group = "UserSetup";
        desc = "Highlight on yank";
        command = "lua vim.highlight.on_yank({higroup = 'IncSearch', timeout = 300})";
      }
    ];
  };
}
