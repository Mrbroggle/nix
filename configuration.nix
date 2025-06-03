{...}: {
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  #  system.copySystemConfiguration = true;

  imports = [
    ./cachix.nix
  ];

  system.stateVersion = "25.05";
}
