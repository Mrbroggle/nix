_: {
  programs.waybar.enable = true;
  xdg.configFile."waybar" = {
    source = ./waybar;
    recursive = true;
  };
}
