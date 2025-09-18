{
  pkgs,
  lib,
  config,
  ...
}: {
  options = {
    hyprland.enable = lib.mkOption {default = false;};
  };
  config = lib.mkIf config.hyprland.enable {
    xdg.portal = {
      enable = true;
      extraPortals = [
        pkgs.xdg-desktop-portal-hyprland
        pkgs.xdg-desktop-portal-gtk
      ];
      config.common.default = ["hyprland" "gtk"];
    };

    wayland.windowManager.hyprland = lib.mkMerge [
      {
        enable = true;
        settings = {
          exec-once = [
            "systemctl --user start hyprpolkitagent"
            "hyprpaper"
            "udiskie"
            "nm-applet"
            "clipse -listen"
            "[workspace 1 silent] ghostty"
            "[workspace 2 silent] vivaldi"
            "[workspace 3 silent] discord"
            "${pkgs.tailscale-systray}/bin/tailscale-systray"
          ];

          misc = {
            force_default_wallpaper = "1"; # Set to 0 or 1 to disable the anime mascot wallpapers
            disable_hyprland_logo = true; # If true disables the random hyprland logo / anime girl background. :(
            focus_on_activate = true;
          };

          windowrulev2 = [
            "suppressevent maximize, class:.*"
            "nofocus,class:^$,title:^$,xwayland:1,floating:1,fullscreen:0,pinned:0"
            "size 751 954, class:(com.mitchellh.ghostty)"
            "float, class:(com.savedra1.clipse)"
            "size 622 652, class:(com.savedra1.clipse)"
            "stayfocused, class:(com.savedra1.clipse)"
            "workspace 3,initialClass:(discord),title:()"
          ];
        };
      }
    ];
  };
}
