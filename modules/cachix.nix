{
  pkgs,
  lib,
  config,
  ...
}:
{
  options = {
    cachix.enable = lib.mkOption { default = true; };
  };
  config = lib.mkIf config.cachix.enable {

    environment.systemPackages = with pkgs; [
      cachix
    ];
  };
}
