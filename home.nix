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

  programs.home-manager.enable = true;
}
