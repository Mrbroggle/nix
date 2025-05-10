{
  pkgs,
  lib,
  config,
  ...
}:
{
  options = {
    libs.enable = lib.mkOption { default = true; };
  };
  config = lib.mkIf config.libs.enable {
    environment.systemPackages = with pkgs; [
      gtk4
      gtk3
      kdePackages.qtwayland
      kdePackages.qtsvg
    ];
  };
}
