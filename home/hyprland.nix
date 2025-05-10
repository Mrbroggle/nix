{
  pkgs,
  lib,
  config,
  ...
}:
{
  options = {
    hyprland.enable = lib.mkOption { default = true; };
    hyprlandLaptop.enable = lib.mkOption { default = false; };
    hyprlandPC.enable = lib.mkOption { default = false; };
  };

  config = lib.mkIf config.hyprland.enable {
    xdg.portal = {
      enable = true;
      extraPortals = [
        pkgs.xdg-desktop-portal-hyprland
        pkgs.xdg-desktop-portal
        pkgs.xdg-desktop-portal-gtk
      ];
    };
    home = lib.mkMerge [
      {

        sessionVariables.NIXOS_OZONE_WL = "1";
      }
      {

        sessionVariables = lib.mkIf config.hyprlandLaptop.enable {
          GDK_SCALE = 2;
        };
      }
    ];
    wayland.windowManager.hyprland = lib.mkMerge [
      {
        enable = true;
        plugins = [
          pkgs.hyprlandPlugins.hyprscroller
          pkgs.hyprlandPlugins.hyprspace
        ];
        settings = {
          exec-once = [
            "systemctl --user start hyprpolkitagent"
            "hypilde"
            "hyprpaper"
            "udiskie"
            "nm-applet &"
            "clipse -listen"
            # "hyprpanel"
          ];
          xwayland = {
            force_zero_scaling = true;
          };

          "$terminal" = "alacritty";
          "$fileManager" = "dolphin";
          "$menu" = "wofi --show drun";
          general = {
            gaps_in = "5";
            gaps_out = "10";

            border_size = "1";

            resize_on_border = false;

            allow_tearing = true;

            layout = "dwindle";
          };

          decoration = {
            rounding = "5";

            active_opacity = "1.0";
            inactive_opacity = "1.0";

            shadow = {
              enabled = false;
              range = "4";
              render_power = "3";
            };

            blur = {
              enabled = false;
            };
          };

          animations = {
            enabled = "yes, please :)";

            bezier = [
              "easeOutQuint,0.23,1,0.32,1"
              "easeInOutCubic,0.65,0.05,0.36,1"
              "linear,0,0,1,1"
              "almostLinear,0.5,0.5,0.75,1.0"
              "quick,0.15,0,0.1,1"
            ];
            animation = [
              "global, 1, 10, default"
              "border, 1, 5.39, easeOutQuint"
              "windows, 1, 4.79, easeOutQuint"
              "windowsIn, 1, 4.1, easeOutQuint, popin 87%"
              "windowsOut, 1, 1.49, linear, popin 87%"
              "fadeIn, 1, 1.73, almostLinear"
              "fadeOut, 1, 1.46, almostLinear"
              "fade, 1, 3.03, quick"
              "layers, 1, 3.81, easeOutQuint"
              "layersIn, 1, 4, easeOutQuint, fade"
              "layersOut, 1, 1.5, linear, fade"
              "fadeLayersIn, 1, 1.79, almostLinear"
              "fadeLayersOut, 1, 1.39, almostLinear"
              "workspaces, 1, 1.94, almostLinear, fade"
              "workspacesIn, 1, 1.21, almostLinear, fade"
              "workspacesOut, 1, 1.94, almostLinear, fade"
            ];
          };

          dwindle = {
            pseudotile = true; # Master switch for pseudotiling. Enabling is bound to mainMod + P in the keybinds section below
            preserve_split = true; # You probably want this
          };

          master = {
            new_status = "master";
          };

          misc = {
            force_default_wallpaper = "1"; # Set to 0 or 1 to disable the anime mascot wallpapers
            disable_hyprland_logo = true; # If true disables the random hyprland logo / anime girl background. :(
            focus_on_activate = true;
          };

          input = {
            sensitivity = "-0.25"; # -1.0 - 1.0, 0 means no modification.
            kb_layout = "us";

            follow_mouse = "1";

            touchpad = {
              natural_scroll = true;
              scroll_factor = "0.4";
            };
          };

          plugin = {
            scroller = {
              column_widths = "one";
              window_heights = "one";
            };
          };

          gestures = {
            workspace_swipe = true;
          };

          "$mainMod" = "SUPER"; # Sets "Windows" key as main modifier

          bind = [
            "$mainMod, Q, exec, $terminal"
            "$mainMod, C, killactive,"
            "$mainMod, M, exit,"
            "$mainMod, E, exec, $fileManager"
            "$mainMod, G, togglefloating,"
            "$mainMod, R, exec, $menu"
            "$mainMod, B, exec, vivaldi"
            "$mainMod, P, pseudo, # dwindle"
            "$mainMod, U, togglesplit, # dwindle"
            "$mainMod, left, movefocus, l"
            "$mainMod, right, movefocus, r"
            "$mainMod, up, movefocus, u"
            "$mainMod, down, movefocus, d"
            "$mainMod, H, movefocus, l"
            "$mainMod, L, movefocus, r"
            "$mainMod, K, movefocus, u"
            "$mainMod, J, movefocus, d"
            "$mainMod SHIFT, right, resizeactive, 10 0"
            "$mainMod SHIFT, left, resizeactive, -10 0"
            "$mainMod SHIFT, up, resizeactive, 0 -10"
            "$mainMod SHIFT, down, resizeactive, 0 10"
            "$mainMod SHIFT, L, resizeactive, 10 0"
            "$mainMod SHIFT, H, resizeactive, -10 0"
            "$mainMod SHIFT, K, resizeactive, 0 -10"
            "$mainMod SHIFT, J, resizeactive, 0 10"
            "$mainMod CTRL, L, workspace, e+1"
            "$mainMod CTRL, H, workspace, e-1"
            "$mainMod, 1, workspace, 1"
            "$mainMod, 2, workspace, 2"
            "$mainMod, 3, workspace, 3"
            "$mainMod, 4, workspace, 4"
            "$mainMod, 5, workspace, 5"
            "$mainMod, 6, workspace, 6"
            "$mainMod, 7, workspace, 7"
            "$mainMod, 8, workspace, 8"
            "$mainMod, 9, workspace, 9"
            "$mainMod, 0, workspace, 10"
            "$mainMod SHIFT, 1, movetoworkspace, 1"
            "$mainMod SHIFT, 2, movetoworkspace, 2"
            "$mainMod SHIFT, 3, movetoworkspace, 3"
            "$mainMod SHIFT, 4, movetoworkspace, 4"
            "$mainMod SHIFT, 5, movetoworkspace, 5"
            "$mainMod SHIFT, 6, movetoworkspace, 6"
            "$mainMod SHIFT, 7, movetoworkspace, 7"
            "$mainMod SHIFT, 8, movetoworkspace, 8"
            "$mainMod SHIFT, 9, movetoworkspace, 9"
            "$mainMod SHIFT, 0, movetoworkspace, 10"
            "$mainMod, mouse_down, workspace, e+1"
            "$mainMod, mouse_up, workspace, e-1"
            "$mainMod, F, fullscreen,"
            "$mainMod SHIFT, S, exec, hyprshot -z -m region -o ~/Pictures"
            "$mainMod, V, exec, alacritty --class clipse -e clipse"
            "CTRL_SHIFT, escape, exec, alacritty -e btop"
            ", xf86poweroff , exec, wlogout"
          ];

          bindm = [
            "$mainMod, mouse:272, movewindow"
            "$mainMod, mouse:273, resizewindow"
            "$mainMod SHIFT, mouse:272, resizewindow"
          ];

          bindel = [
            ",XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"
            ",XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
            ",XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
            ",XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
          ];

          bindl = [
            ", XF86AudioNext, exec, playerctl next"
            ", XF86AudioPause, exec, playerctl play-pause"
            ", XF86AudioPlay, exec, playerctl play-pause"
            ", XF86AudioPrev, exec, playerctl previous"
          ];

          windowrulev2 = [
            "suppressevent maximize, class:.*"
            "nofocus,class:^$,title:^$,xwayland:1,floating:1,fullscreen:0,pinned:0"
            "size 751 954, class:(Alacritty)"
            "float, class:(clipse)"
            "size 622 652, class:(clipse)"
            "stayfocused, class:(clipse)"
          ];
        };
      }
      {
        settings =
          if config.hyprlandLaptop.enable then
            {
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
            }
          else if config.hyprlandPC.enable then
            {
              monitor = [
                "DP-2, 1920x1080@165,0x0,1"
                "HDMI-A-2, 1920x1080@100,-1920x-400,1,transform,1"
              ];
            }
          else
            {
              monitor = [
                ", preferred, auto-left, 1"
              ];
            };
      }

    ];

    services.kanshi = lib.mkIf config.hyprlandLaptop.enable {
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
    };
  };
}
