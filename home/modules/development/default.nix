{ 
pkgs, 
# nur, 
system, 
... }:

{
home.packages = with pkgs; [
    python3
    rustup
    (stable.postgresql_16)
    sqlite
    nodejs_22 
    go 
    prettier 
    eslint

     vscode-js-debug
     pnpm
     nixpkgs-fmt
     stylua
    # nur.legacyPackages.${system}.repos.mic92.hello-nur
  ];
}
