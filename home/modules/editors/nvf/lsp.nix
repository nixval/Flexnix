# modules/editors/neovim/lsp.nix
{ ... }:

{
  programs.nvf.settings = {
    # ----------------------------------------------------
    # Language Server Protocol (LSP)
    # ----------------------------------------------------
    vim.lsp.servers.astro.enable = true;

    # ----------------------------------------------------
    # Formatter (Conform)
    # ----------------------------------------------------
    vim.formatter.conform-nvim = {
      enable = true;
      setupOpts.formatters_by_ft = {
        # Web
        javascript = [ "prettier" ];
        typescript = [ "prettier" ];
        javascriptreact = [ "prettier" ];
        typescriptreact = [ "prettier" ];
        astro = [ "prettier" ];
        css = [ "prettier" ];
        html = [ "prettier" ];
        markdown = [ "prettier" ];
        
        # Lainnya
        lua = [ "stylua" ];
        nix = [ "nixpkgs-fmt" ];
      };
    };

    # ----------------------------------------------------
    # Linter (nvim-lint)
    # ----------------------------------------------------
    vim.diagnostics.nvim-lint = {
      enable = true;
      linters_by_ft = {
        javascript = [ "eslint" ];
        typescript = [ "eslint" ];
        javascriptreact = [ "eslint" ];
        typescriptreact = [ "eslint" ];
      };
    };
  };
}
