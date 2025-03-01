{...}: {
  networking.hostName = "laptop-nixos"; # Define your hostname.
  imports = [
    ../modules/default.nix
    ./laptop/laptop-hardware-configuration.nix
  ];
}
