_: {
  home.sessionVariables = {
    GDK_SCALE = 2;
  };
  wayland.windowManager.hyprland.settings = {
    monitor = [
      "eDP-1, 2880x1920@120, 0x0, 1.875"
    ];
    env = [
      "GDK_SCALE,2"
      "XCURSOR_SIZE,32"
    ];
    /*
    animations = {
      enabled = "false";
    };
    */
  };
}
