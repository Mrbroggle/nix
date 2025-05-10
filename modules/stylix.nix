{
  pkgs,
  lib,
  config,
  ...
}:
{
  options = {
    stylixModule.enable = lib.mkOption { default = true; };
  };
  config = lib.mkIf config.stylixModule.enable {
    stylix = {
      enable = true;
      base16Scheme = "${pkgs.base16-schemes}/share/themes/tokyo-night-storm.yaml";
      image = ../home/wall0.png;
      cursor = {
        package = pkgs.apple-cursor;
        name = "macOS";
        size = 24;
      };
      polarity = "dark";
      autoEnable = true;
      targets = {
        plymouth.enable = false;
      };
    };
  };
}
