{
  lib,
  config,
  ...
}: let
  waylandDE = {
    swaync.enable = true;
    styling.enable = true;
    uni.enable = true;
    wlogout.enable = true;
    waybar.enable = true;
    shell.enable = true;
    desktopApps.enable = true;
    protondrive.enable = false;
    security.enable = true;
  };
  hyprDE = lib.mkMerge [
    {
      hyprland.enable = true;
      hyprpaper.enable = true;
    }
    waylandDE
  ];
  niriDE = lib.mkMerge [
    {
      niri.enable = true;
    }
    waylandDE
  ];
  hyprmerged = lib.mkMerge [
    (lib.mkIf (config.hyprlandLaptop.enable || config.hyprlandPC.enable) hyprDE)
  ];
  nirimerged = lib.mkMerge [
    (lib.mkIf (config.niriLaptop.enable || config.niriPC.enable) hyprDE)
  ];
in {
  options = {
    hyprlandLaptop.enable = lib.mkOption {default = false;};
    hyprlandPC.enable = lib.mkOption {default = false;};
    niriLaptop.enable = lib.mkOption {default = false;};
    niriPC.enable = lib.mkOption {default = false;};
  };
  config = lib.mkMerge [
    hyprmerged
    nirimerged
  ];
}
