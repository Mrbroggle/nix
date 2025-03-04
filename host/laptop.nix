{...}: {
  networking.hostName = "laptop-nixos"; # Define your hostname.
  imports = [
    ../modules/default.nix
    ../modules/laptopDefault.nix
    ./laptop/laptop-hardware-configuration.nix
  ];
}
