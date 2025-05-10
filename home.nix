_: {
  home = {
    username = "gradyb";
    homeDirectory = "/home/gradyb";

    stateVersion = "25.05";

    sessionVariables = {
    };
  };
  imports = [
    ./home/default.nix
  ];

  programs.home-manager.enable = true;
}
