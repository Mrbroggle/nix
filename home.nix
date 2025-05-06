{ pkgs, ... }:
{
  home = {
    username = "gradyb";
    homeDirectory = "/home/gradyb";

    stateVersion = "25.05";

    packages = [
    ];

    file = {
    };

    sessionVariables = {
    };
  };
  imports = [
    ./home/default.nix
  ];

  nixpkgs.config.allowUnfree = true;
  programs.home-manager.enable = true;
}
