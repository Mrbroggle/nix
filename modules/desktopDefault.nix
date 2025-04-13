{...}: {
  imports = [
    ./browser.nix
    ./desktopApps.nix
    ./office.nix
    ./plymouth.nix
    ./kanata
    ./multirotor.nix
    ./mail.nix
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
}
