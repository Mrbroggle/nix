{...}: {
  networking.hostName = "pc-nixos"; # Define your hostname.
  imports = [
    ../modules/default.nix
    ../modules/pcdefault.nix
    ./pc/pc-hardware-configuration.nix
  ];
}
