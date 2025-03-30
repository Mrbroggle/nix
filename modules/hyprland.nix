{
  pkgs,
  inputs,
  lib,
  ...
}: {
  programs = {
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
    logind.extraConfig = ''
      HandlePowerKey=ignore
    '';
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
    hyprlock
    hyprpolkitagent
  ];
}
