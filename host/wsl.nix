_:{
  networking.hostName = "wsl-nixos"; # Define your hostname.
  imports = [
    ../modules/default.nix
    ../modules/wslDefault.nix
  ];

}
