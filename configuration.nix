{...}: {
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ./modules/default.nix
  ];

  nixpkgs.config.allowUnfree = true;

  nix.settings.experimental-features = ["nix-command" "flakes"];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  #  system.copySystemConfiguration = true;

  system.stateVersion = "24.11";
}
