{
  pkgs,
  lib,
  config,
  styles,
  ...
}: {
  options = {
    stylixModule.enable = lib.mkOption {default = true;};
  };
  config = lib.mkIf config.stylixModule.enable {
    stylix = {
      enable = true;
      inherit (styles) image base16Scheme;
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
