{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    bato
    batmon
  ];
  services = {
    power-profiles-daemon.enable = true;
    upower.enable = true;
  };
}
