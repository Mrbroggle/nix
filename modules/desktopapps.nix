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
  ];
  services.udisks2.enable = true;

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
  programs.steam.gamescopeSession.enable = true;
  programs.spicetify = let
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
}
