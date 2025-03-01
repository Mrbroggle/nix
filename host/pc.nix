{...}: {
  networking.hostName = "pc-nixos"; # Define your hostname.
  imports = [
    ../modules/default.nix
    ./pc/pc-hardware-configuration.nix
  ];
}
