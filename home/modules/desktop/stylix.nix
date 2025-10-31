{ pkgs, vars, inputs, lib, ... }:

lib.mkIf vars.enableStylix {
  imports = [ inputs.stylix.homeManagerModules.stylix ];

  stylix = {
    enable = true;
    image = ../assets/wallpapers/default.jpg;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/gruvbox-dark-hard.yaml";
    fonts = {
      monospace = {
        package = pkgs.nerdfonts.override { fonts = [ "FiraCode" ]; };
        name = "FiraCode Nerd Font";
      };
    };
  };
}
