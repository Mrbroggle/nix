{ inputs, ... }:
{
  home = {
    username = "gradyb";
    homeDirectory = "/home/gradyb";

    stateVersion = "25.05";

    sessionVariables = {
    };
  };
  imports = [
    (inputs.import-tree ./home)
  ];

  programs.home-manager.enable = true;
}
