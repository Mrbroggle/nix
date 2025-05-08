{ ... }:
{
  networking.hostName = "pc-nixos"; # Define your hostname.
  imports = [
    ../modules/default.nix
    ../modules/pcDefault.nix
    ./pc-nixos/pc-hardware-configuration.nix
  ];
}
