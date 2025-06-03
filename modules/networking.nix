{
  lib,
  config,
  pkgs,
  ...
}: {
  options = {
    networking.enable = lib.mkOption {default = true;};
    tailscale.enable = lib.mkOption {default = true;};
  };
  config = {
    # networking.wireless.iwd.enable = true;
    networking = lib.mkIf config.networking.enable {
      networkmanager.enable = true;
      # nftables.enable = true;
      # firewall = {
      #   enable = true;
      # };
    };
    environment.systemPackages = with pkgs; [
      protonvpn-gui
    ];
    # networking.networkmanager.wifi.backend = "iwd";

    # dnsmasq.enable = true;
    # environment.systemPackages = with pkgs; [
    #   nftables
    #   dnsmasq
    # ];

    services = lib.mkIf config.tailscale.enable {
      tailscale = {
        enable = true;
        useRoutingFeatures = "both";
      };
    };
  };
}
