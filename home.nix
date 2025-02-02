{ config, pkgs, lib, ... }:

{
  home.username = "gradyb";
  home.homeDirectory = "/home/gradyb";

  imports = [
    ./home/default.nix
  ];
  home.stateVersion = "24.11";

  home.packages = [

  ];

  home.file = {

  };

  home.sessionVariables = {

  };

  programs.home-manager.enable = true;
}
