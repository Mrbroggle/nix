{ pkgs, config, inputs, ... }: {
  programs.hyprland.enable = true;
  programs.hyprland.package = inputs.hyprland.packages."${pkgs.system}".hyprland;
  programs.regreet.enable = true;
  services.xserver.xkb = {
    layout = "au";
    variant = "";
  };
  services.xserver.enable = true;
  services.displayManager.autoLogin.enable = true;
  services.displayManager.autoLogin.user = "gradyb";
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
    hyprlandPlugins.hyprgrass
    hyprlandPlugins.hyprbars
    hyprlandPlugins.hypr-dynamic-cursors
    hyprlandPlugins.hyprtrails
  ];
}

