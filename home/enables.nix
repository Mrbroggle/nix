{
  lib,
  config,
  ...
}: let
  hyprDE = {
    hyprland.enable = true;
    swaync.enable = true;
    styling.enable = true;
    uni.enable = true;
    wlogout.enable = true;
    waybar.enable = true;
    shell.enable = true;
    hyprpaper.enable = true;
    desktopApps.enable = true;
    protondrive.enable = false;
    security.enable = true;
  };
  merged = lib.mkMerge [
    (lib.mkIf (config.hyprlandLaptop.enable || config.hyprlandPC.enable) hyprDE)
  ];
in {
  options = {
    hyprlandLaptop.enable = lib.mkOption {default = false;};
    hyprlandPC.enable = lib.mkOption {default = false;};
  };
  config = lib.mkMerge [
    merged
  ];
}
