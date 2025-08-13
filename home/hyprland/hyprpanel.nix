{
  lib,
  config,
  ...
}: {
  options = {
    hyprpanel.enable = lib.mkOption {default = false;};
  };
  config = lib.mkIf config.hyprpanel.enable {
    programs.hyprpanel = {
      enable = true;
    };
    wayland.windowManager.hyprland.settings = {
      exec-once = ["hyprpanel"];
      bind = [
        "$mainMod, N, exec, hyprpanel -t notificationsmenu"
      ];
    };
  };
}
