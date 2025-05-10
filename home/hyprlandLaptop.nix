_: {
  home.sessionVariables = {
    GDK_SCALE = 2;
  };
  services.kanshi = {
    enable = true;
    systemdTarget = "hyprland-session.target";

    settings = [
      {
        profile = {
          name = "Undocked";
          exec = "notify-send -t 10000 Kanshi 'Swaped to Undocked Config'";
          outputs = [
            {
              criteria = "eDP-1";
              scale = 1.875;
              # scale = 1.0;
              # mode = "1920x1200@120Hz";
              status = "enable";
            }
          ];
        };

      }
      {
        profile = {
          name = "Docked";
          exec = "notify-send -t 10000 Kanshi 'Swaped to Docked Config'";
          outputs = [
            {
              criteria = "Lenovo Group Limited G24-20 U533B517";
              position = "0,0";
              mode = "1920x1080@165.00Hz";
            }
            {
              criteria = "Acer Technologies KA222Q E3 14300123E3E00";
              position = "-1080,-200";
              mode = "1920x1080@100.00Hz";
              transform = "90";
            }
            {
              criteria = "eDP-1";
              status = "disable";
            }
          ];
        };
      }
    ];
    # profiles = {
    #   undocked = {
    #     exec = "notify-send -t 10000 Kanshi 'Swaped to Undocked Config'";
    #     outputs = [
    #       {
    #         criteria = "eDP-1";
    #         scale = 1.875;
    #         status = "enable";
    #       }
    #     ];
    #   };
    #   docked = {
    #     exec = "notify-send -t 10000 Kanshi 'Swaped to Docked Config'";
    #     outputs = [
    #       {
    #         criteria = "Lenovo Group Limited G24-20 U533B517";
    #         position = "0,0";
    #         mode = "1920x1080@144";
    #       }
    #       {
    #         criteria = "Acer Technologies KA222Q E3 14300123E3E00";
    #         position = "-1080,-200";
    #         mode = "1920x1080@100";
    #         transform = "90";
    #       }
    #       {
    #         criteria = "eDP-1";
    #         status = "disable";
    #       }
    #     ];
    #   };
    # };
  };
  wayland.windowManager.hyprland.settings = {
    # backup for is Kanshi dies
    monitor = [
      "eDP-1, 2880x1920@120, 0x0, 1.875"
      ", preferred, auto-left, 1"
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
