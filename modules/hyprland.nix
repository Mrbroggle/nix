{
  pkgs,
  inputs,
  lib,
  ...
}: {
  programs = {
    hyprland.enable = true;
    hyprland.package = inputs.hyprland.packages."${pkgs.system}".hyprland;
    /*
    regreet = {
      enable = true;
      settings = lib.mkForce {
        env = {
          STATE_DIR = "/home/gradyb/.temp/";
        };
      };
    };
    */
  };

  services = {
    xserver.xkb = {
      layout = "au";
      variant = "";
    };
    xserver.enable = true;
    displayManager = {
      sddm = {
        enable = true;
        wayland.enable = true;
      };
      autoLogin.enable = true;
      autoLogin.user = "gradyb";
    };
  };

  environment.systemPackages = with pkgs; [
    alacritty
    networkmanager
    wofi
    swaynotificationcenter
    udiskie
    wl-clipboard
    clipse
    hyprshot
    hyprpaper
    hypridle
    hyprlock
    hyprpolkitagent
  ];
}
