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
      powertop
    ];
    powerManagement = {
      enable = true;
      powertop.enable = true;
      cpuFreqGovernor = "powersave";
    };
    services = {
      thermald.enable = false;
      power-profiles-daemon.enable = true;
      upower.enable = true;
      auto-cpufreq = {
        enable = false;
        settings = {
          battery = {
            governor = "powersave";
            turbo = "never";
          };
          charger = {
            governor = "powersave";
            turbo = "auto";
          };
        };
      };
      system76-scheduler = {
        enable = true;
        useStockConfig = true;
      };
    };
  };
}
