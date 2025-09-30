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
    sddm.enable = true;
    kdeconnect.enable = true;
    xdg.portal = {
      enable = true;
      extraPortals = [
        pkgs.xdg-desktop-portal-hyprland
      ];
      config.common.default = "*";
    };

    services.displayManager = {
      defaultSession = "hyprland";
      sessionPackages = [pkgs.hyprland];
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
        shikane
      ];
      sessionVariables = {
        NIXOS_WAYLAND = "1";
        NIXOS_OZONE_WL = "1";
      };
    };
  };
}
