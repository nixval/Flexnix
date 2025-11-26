# modules/editors/neovim/core.nix
{ lib, ... }:

{
  programs.nvf.settings = {
    # ----------------------------------------------------
    # Opsi Dasar
    # ----------------------------------------------------
    vim.options = {
      shiftwidth = 2;
      tabstop = 2;
      expandtab = true;
      clipboard = "unnamedplus";
      splitbelow = true;
      splitright = true;
      wrap = false;
      undofile = true;
      undodir = lib.generators.mkLuaInline "vim.fn.stdpath('state') .. '/undo'";

    };
    vim.lineNumberMode = "relNumber";

    # ----------------------------------------------------
    # Integrasi Git
    # ----------------------------------------------------
    vim.git.gitsigns.enable = true;

    # ----------------------------------------------------
    # Treesitter
    # ----------------------------------------------------
    vim.treesitter.enable = true;
    vim.languages = {
      # Kita 'merge' semua 'languages' di sini
      nix.enable = true;
      lua.enable = true;
      ts.enable = true;
      go.enable = true;

      # Parser Treesitter
      astro.treesitter.enable = true;
      html.treesitter.enable = true;
      css.treesitter.enable = true;
      markdown.treesitter.enable = true;
      bash.treesitter.enable = true;
    };

    # ----------------------------------------------------
    # Autocompletion
    # ----------------------------------------------------
    vim.autocomplete.nvim-cmp.enable = true;
  };
}
