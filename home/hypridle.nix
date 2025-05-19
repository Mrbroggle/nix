{ lib, config, ... }:
{
  options = {
    hypridle.enable = lib.mkOption { default = true; };
  };
  config = lib.mkIf config.hypridle.enable {
    wayland.windowManager.hyprland.settings.exec-once = [ "swaync" ];
    services.hypridle = {
      enable = false;
      settings = {
        general = {
          lock_cmd = "pidof hyprlock || hyprlock";
          before_sleep_cmd = "loginctl lock-session";
          after_sleep_cmd = "hyprctl dispatch dpms on";
        };

        listener = [
          {
            timeout = 120;
            on-timeout = "hyprctl dispatch dpms off";
            on-resume = "hyprctl dispatch dpms on";
          }
        ];
      };
    };
  };
}
