{ inputs, ... }:
{
  # imports = [ inputs.hyprpanel.homeManagerModules.hyprpanel ];
  #
  # programs.hyprpanel = {
  #   enable = true;
  # };
  wayland.windowManager.hyprland.settings.exec-once = [ "hyprpanel" ];
  bind = [
    "$mainMod, N, exec, hyprpanel -t notificationsmenu"
  ];
}
