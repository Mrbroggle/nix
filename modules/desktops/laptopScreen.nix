{
  pkgs,
  lib,
  config,
  ...
}: {
  options = {
    laptopScreen.enable = lib.mkOption {default = false;};
  };
  config = lib.mkIf config.laptopScreen.enable {
    boot.blacklistedKernelModules = [
      "hid_sensor_hub"
    ];

    environment.systemPackages = with pkgs; [
      brightnessctl
      bc
    ];
  };
}
