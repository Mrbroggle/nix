{pkgs, ...}: {
  home = {
    username = "gradyb";
    homeDirectory = "/home/gradyb";

    stateVersion = "24.11";

    packages = [
      pkgs.gyroflow
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
