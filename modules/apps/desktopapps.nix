{
  pkgs,
  lib,
  config,
  inputs,
  ...
}: {
  options = {
    desktopApps.enable = lib.mkOption {default = true;};
  };
  config = lib.mkIf config.desktopApps.enable {
    environment.systemPackages = with pkgs; [
      whatsie
      deskflow
      mpv
      celluloid
      neovide
      gnome-network-displays
      gparted
      libsForQt5.okular
      kdePackages.dolphin
      obsidian
      qbittorrent
      networkmanagerapplet
      playerctl # # for Spotify keybinds
    ];

    services = {
      udisks2.enable = true;
      smartd.enable = true;
      gvfs.enable = true;
    };

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
      spicetify = let
        spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.system};
      in {
        enable = true;
        enabledExtensions = with spicePkgs.extensions; [
          adblock
          hidePodcasts
          shuffle
        ];
        enabledCustomApps = with spicePkgs.apps; [
          newReleases
          ncsVisualizer
        ];
        enabledSnippets = with spicePkgs.snippets; [
          pointer
        ];
      };
    };
  };
}
