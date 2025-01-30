{ config, lib, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./modules/default.nix
    ];

  nixpkgs.config.allowUnfree = true;

  nix.optimise.automatic = true;
  nix.optimise.dates = [ "07:45" ];

  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 30d";
  };

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  system.copySystemConfiguration = true;

  system.stateVersion = "24.11";

}

