{...}: {
  imports = [
    ./desktopApps.nix
    ./office.nix
    ./plymouth.nix
    ./kanata
    ./multirotor.nix
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
}
