{
  pkgs,
  inputs,
  lib,
  ...
}: {
  programs = {
    hyprland.enable = true;
    hyprland.package = inputs.hyprland.packages."${pkgs.system}".hyprland;
    regreet = {
      enable = true;
      settings = lib.mkForce {
        default_session = {
          command = "Hyprland";
          user = "gradyb";
        };
      };
    };
  };

  services = {
    xserver.xkb = {
      layout = "au";
      variant = "";
    };
    xserver.enable = true;
    displayManager.autoLogin.enable = true;
    displayManager.autoLogin.user = "gradyb";
  };

  environment.systemPackages = with pkgs; [
    alacritty
    networkmanager
    wofi
    swaynotificationcenter
    waybar
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
