{
  pkgs,
  lib,
  config,
  ...
}: {
  options = {
    desktopApps.enable = lib.mkOption {default = false;};
  };
  config = lib.mkIf config.desktopApps.enable {
    home.packages = with pkgs; [prismlauncher];
    programs = {
      nixcord = {
        enable = true;
      };
      ghostty = {
        enable = true;
        enableFishIntegration = true;
        settings = {
          font-family = "FiraCode Nerd Font Bold";
          confirm-close-surface = false;
        };
      };
    };
  };
}
