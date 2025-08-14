{
  lib,
  config,
  styles,
  ...
}: {
  options = {
    hyprpaper.enable = lib.mkOption {default = false;};
  };
  config = lib.mkIf config.hyprpaper.enable {
    services.hyprpaper = {
      enable = true;
      settings = {
        ipc = "on";
        preload = [
          "${styles.image}"
        ];

        wallpaper = [
          ",${styles.image}"
        ];
      };
    };
  };
}
