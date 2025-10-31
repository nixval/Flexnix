# File: ~/dotfiles/nix/modules/tools/yazi/settings.nix
{
  log.enabled = true;
  
  mgr = {
    show_hidden = true;
    # // BARU: Mengaktifkan linemode dari plugin 'git.yazi'
    linemode = "git";
  };

  preview = {
    image_protocol = "ueberzug";
    text_chunks = 5;
    max_width = 1000;
    max_height = 1000;
  };

  theme = {
    use = "catppuccin-mocha";
  };
}
