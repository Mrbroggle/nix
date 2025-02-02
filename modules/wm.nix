{
  pkgs,
  inputs,
  ...
}: {
  programs = {
    hyprland.enable = true;
    hyprland.package = inputs.hyprland.packages."${pkgs.system}".hyprland;
    regreet.enable = true;
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
    hyprshot
    hyprpaper
    hypridle
    hyprlock
    hyprpolkitagent
  ];
}
