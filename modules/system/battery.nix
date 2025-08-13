{
  pkgs,
  lib,
  config,
  ...
}: {
  options = {
    battery.enable = lib.mkOption {default = true;};
  };
  config = lib.mkIf config.battery.enable {
    environment.systemPackages = with pkgs; [
      bato
      batmon
    ];
    services = {
      power-profiles-daemon.enable = true;
      upower.enable = true;
    };
  };
}
