{
  pkgs,
  lib,
  config,
  ...
}: {
  options = {
    niri.enable = lib.mkOption {default = false;};
  };
  config = lib.mkIf config.niri.enable {
    sddm.enable = true;
    kdeconnect.enable = true;
    security.polkit.enable = true;
    xdg.portal = {
      enable = true;
      config.common.default = "*";
    };

    programs.niri.enable = true;
    services.displayManager.sessionPackages = [pkgs.niri];
    environment = {
      systemPackages = with pkgs; [
        ghostty
        networkmanager
        wofi
        udiskie
        wl-clipboard
        clipse
        shikane
      ];
      sessionVariables = {
        NIXOS_WAYLAND = "1";
        NIXOS_OZONE_WL = "1";
      };
    };
  };
}
