{ lib, config, ... }:
{
  options = {
    hyprpaper.enable = lib.mkOption { default = true; };
  };
  config = lib.mkIf config.hyprpaper.enable {
    services.hyprpaper = {
      enable = true;
      settings = {
        ipc = "on";
      };
    };
  };
}
