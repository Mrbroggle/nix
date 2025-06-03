{
  pkgs,
  lib,
  config,
  ...
}: {
  options = {
    rclone.enable = lib.mkOption {default = true;};
  };
  config = lib.mkIf config.rclone.enable {
    environment.systemPackages = [
      pkgs.rclone
    ];
  };
}
