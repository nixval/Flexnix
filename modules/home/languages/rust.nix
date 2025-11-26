{ config, lib, pkgs, ... }:

let
  cfg = config.flexnix.modules.languages.rust;
in
{
  options.flexnix.modules.languages.rust = {
    enable = lib.mkEnableOption "Rust language toolchain";
  };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      rustup
      # cargo is included in rustup
    ];
  };
}
