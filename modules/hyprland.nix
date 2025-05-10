{
  pkgs,
  lib,
  config,
  ...
}:
{
  options = {
    hyprland.enable = lib.mkOption { default = true; };
  };
  config = lib.mkIf config.hyprland.enable {
    programs = {
      /*
        regreet = {
          enable = true;
          settings = lib.mkForce {
            env = {
              STATE_DIR = "/home/gradyb/.temp/";
            };
          };
        };
      */
    };

    xdg.portal = {
      enable = true;
      wlr.enable = false;
      extraPortals = [
        pkgs.xdg-desktop-portal-gtk
      ];
      configPackages = [
        pkgs.xdg-desktop-portal-gtk
        pkgs.xdg-desktop-portal
      ];
    };

    services = {
      xserver.xkb = {
        layout = "au";
        variant = "";
      };
      xserver.enable = true;
      displayManager = {
        defaultSession = "hyprland";
        sddm = {
          enable = true;
          wayland.enable = true;
          theme = "where_is_my_sddm_theme";
          settings = {
            Autologin = {
              User = "gradyb";
            };
          };
        };
        sessionPackages = [ pkgs.hyprland ];
      };
      logind.extraConfig = ''
        HandlePowerKey=ignore
      '';
    };
    programs = {
      uwsm = {
        enable = true;
        waylandCompositors = {
          hyprland = {
            prettyName = "Hyprland";
            comment = "Hyprland compositor managed by UWSM";
            binPath = "/run/current-system/sw/bin/Hyprland";
          };
        };
      };
    };
    environment.systemPackages = with pkgs; [
      alacritty
      networkmanager
      wofi
      udiskie
      wl-clipboard
      clipse
      hyprshot
      hyprpaper
      hyprlock
      hyprpolkitagent
      where-is-my-sddm-theme
      shikane
      # hyprpanel
    ];
  };
}
