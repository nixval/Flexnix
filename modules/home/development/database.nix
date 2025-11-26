{ config, lib, pkgs, ... }:

let
  cfg = config.flexnix.modules.development.database;
in
{
  options.flexnix.modules.development.database = {
    enable = lib.mkEnableOption "Database tools (Postgres, SQLite)";
  };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      stable.postgresql_16 # Using stable overlay as requested
      sqlite
    ];
  };
}
