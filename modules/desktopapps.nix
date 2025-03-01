{
  pkgs,
  inputs,
  ...
}: {
  environment.systemPackages = with pkgs; [
    mpv
    celluloid
    neovide
    gnome-network-displays
    discord
    gparted
    kdePackages.qtwayland
    kdePackages.qtsvg
    kdePackages.dolphin
    obsidian
    qbittorrent
  ];

  services = {
    udisks2.enable = true;
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
        shuffle # shuffle+ (special characters are sanitized out of extension names)
      ];
      enabledCustomApps = with spicePkgs.apps; [
        newReleases
        ncsVisualizer
      ];
      enabledSnippets = with spicePkgs.snippets; [
        rotatingCoverart
        pointer
      ];
    };
  };
}
