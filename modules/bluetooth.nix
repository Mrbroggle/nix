{
  pkgs,
  lib,
  config,
  ...
}: {
  options = {
    bluetooth.enable = lib.mkOption {default = true;};
  };
  config = lib.mkIf config.bluetooth.enable {
    hardware.bluetooth.enable = true;
    hardware.bluetooth.powerOnBoot = true;
    environment.systemPackages = with pkgs; [
      blueman
      bluez
    ];
    services.blueman.enable = true;
  };
}
