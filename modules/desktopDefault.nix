{ ... }:
{
  imports = [
    ./browser.nix
    ./desktopapps.nix
    ./office.nix
    ./plymouth.nix
    ./kanata.nix
    ./multirotor.nix
    ./mail.nix
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
}
