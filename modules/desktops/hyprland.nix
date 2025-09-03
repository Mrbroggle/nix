{
  pkgs,
  lib,
  config,
  ...
}: {
  options = {
    hyprland.enable = lib.mkOption {default = true;};
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
      extraPortals = [
        pkgs.xdg-desktop-portal-hyprland
      ];
    };

    services = {
      xserver.xkb = {
        # layout = "us";
        # variant = "colemak";
      };
      xserver.enable = true;
      displayManager = {
        defaultSession = "hyprland";
        sddm = {
          enable = true;
          wayland.enable = true;
          theme = "sddm-astronaut-theme";
          settings = {
            Autologin = {
              User = "gradyb";
            };
          };
        };
        sessionPackages = [pkgs.hyprland];
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
    environment = {
      systemPackages = with pkgs; [
        # alacritty
        ghostty
        networkmanager
        wofi
        udiskie
        wl-clipboard
        clipse
        hyprshot
        hyprpaper
        hyprlock
        hyprpolkitagent
        sddm-astronaut
        kdePackages.qtmultimedia
        shikane
        libei
        # hyprpanel
      ];
      sessionVariables = {
        NIXOS_WAYLAND = "1";
        NIXOS_OZONE_WL = "1";
      };
    };
  };
}
