{
  inputs,
  lib,
  config,
  ...
}:
{
  # imports = [ inputs.hyprpanel.homeManagerModules.hyprpanel ];
  #
  # programs.hyprpanel = {
  #   enable = true;
  # };
  options = {
    hyprpanel.enable = lib.mkOption { default = true; };
  };
  config = lib.mkIf config.hyprpanel.enable {
    wayland.windowManager.hyprland.settings = {
      exec-once = [ "hyprpanel" ];
      bind = [
        "$mainMod, N, exec, hyprpanel -t notificationsmenu"
      ];
    };
  };
}
