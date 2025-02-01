{ config, pkgs, lib, ... }:

{
  home.username = "gradyb";
  home.homeDirectory = "/home/gradyb";

  imports = [

  ];
  home.stateVersion = "24.11";

  home.packages = [

  ];

  home.file = {

  };

  home.sessionVariables = {

  };

  wayland.windowManager.hyprland = {
      enable = true;

      settings = {

        };
    }

  programs.home-manager.enable = true;
}
