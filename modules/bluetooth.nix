{pkgs, ...}: {
  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;
  environment.systemPackages = with pkgs; [
    blueman
    bluez
  ];
  services.blueman.enable = true;
}
