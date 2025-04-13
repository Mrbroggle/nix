{...}: {
  nixpkgs.config.allowUnfree = true;

  nix.settings.experimental-features = ["nix-command" "flakes"];

  #  system.copySystemConfiguration = true;

  system.stateVersion = "25.05";
}
