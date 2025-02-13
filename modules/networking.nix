{...}: {
  networking.hostName = "gradyb-nixos"; # Define your hostname.
  # networking.wireless.iwd.enable = true;
  networking.networkmanager.enable = true;
  # networking.networkmanager.wifi.backend = "iwd";
}
