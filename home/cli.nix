{
  pkgs,
  lib,
  config,
  ...
}: {
  options = {
    cli.enable = lib.mkOption {default = true;};
  };
  config = lib.mkIf config.cli.enable {
    home.packages = with pkgs; [
      btop
    ];
  };
}
