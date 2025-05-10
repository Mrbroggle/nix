{
  pkgs,
  lib,
  config,
  ...
}:
{
  options = {
    desktopApps.enable = lib.mkOption { default = true; };
  };
  config = lib.mkIf config.desktopApps.enable {
    home.packages = with pkgs; [ prismlauncher ];
  };
}
