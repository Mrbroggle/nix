{...}: {
  networking.hostName = "pc-nixos"; # Define your hostname.
  imports = [
    ../modules/default.nix
    ../modules/pcDefault.nix
    ./pc/pc-hardware-configuration.nix
  ];
}
