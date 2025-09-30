{
  pkgs,
  lib,
  config,
  ...
}: {
  options = {
    sddm.enable = lib.mkOption {default = false;};
  };
  config = lib.mkIf config.sddm.enable {
    services = {
      xserver.enable = true;
      displayManager = {
        sddm = {
          enable = true;
          package = pkgs.kdePackages.sddm;
          wayland.enable = true;
          theme = "sddm-astronaut-theme";
          settings = {
            Autologin = {
              # User = "gradyb";
            };
          };
        };
      };
      logind.settings.Login = {
        HandlePowerKey = "ignore";
      };
    };
    environment = {
      systemPackages = with pkgs; [
        kdePackages.qtmultimedia
        libei
        (sddm-astronaut.override {
          embeddedTheme = "black_hole";
        })
      ];
    };
  };
}
