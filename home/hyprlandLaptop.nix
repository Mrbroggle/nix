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
      "XCURSOR_SIZE,24"
    ];
    /*
    animations = {
      enabled = "false";
    };
    */
    bind = [
      ", code:232, exec, brightnessctl set -10% > /dev/null"
      ", code:233, exec, brightnessctl set +10% > /dev/null"
    ];
    bindl = [
      ", switch:on:[switch name], exec, hyprctl keyword monitor \"eDP-1, disable\""
      ", switch:off:[switch name], exec, hyprctl keyword monitor \"eDP-1, 2560x1600, 0x0, 1\""
    ];
  };
}
