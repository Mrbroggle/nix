{
  lib,
  config,
  pkgs,
  ...
}:
let
  hyprland = pkgs.fetchFromGitHub {
    owner = "hyprwm";
    repo = "Hyprland";
    rev = "be6ee6e55f08387a9e2fbf712c061fb238a70319";
    hash = "sha256-I7aEITHjYECm/41OI4lEMsciD4f7opi8wJVIJVxAGOQ=";
  };
in
{
  options = {
    hyprpaper.enable = lib.mkOption { default = false; };
  };
  config = lib.mkIf config.hyprpaper.enable {
    services.hyprpaper = {
      enable = true;
      settings = {
        ipc = "on";
        preload = [
          "${hyprland}/assets/install/wall0.png"
        ];

        wallpaper = [
          ",${hyprland}/assets/install/wall0.png"
        ];
      };
    };
  };
}
