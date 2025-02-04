{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    mpv
    celluloid
    neovide
    dolphin
    gnome-network-displays
    spotify
    discord
  ];
  programs = {
    steam = {
      enable = true;
      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = true;
      localNetworkGameTransfers.openFirewall = true;
    };
    gamescope = {
      enable = true;
      capSysNice = true;
    };
  };
}
