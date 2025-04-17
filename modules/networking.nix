{ pkgs, ... }:
{
  # networking.wireless.iwd.enable = true;
  networking = {
    networkmanager.enable = true;
    # nftables.enable = true;
    # firewall = {
    #   enable = true;
    # };
  };
  # networking.networkmanager.wifi.backend = "iwd";
  services = {
    tailscale = {
      enable = true;
      useRoutingFeatures = "both";
    };
    # dnsmasq.enable = true;
  };

  # environment.systemPackages = with pkgs; [
  #   nftables
  #   dnsmasq
  # ];

}
