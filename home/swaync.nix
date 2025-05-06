{ pkgs, ... }:
let
  dots = pkgs.fetchFromGitHub {
    owner = "Mrbroggle";
    repo = "elifouts-dotfiles";
    rev = "e1ebaf981af0cf0e57c75b85114b756b20c99169";
    hash = "sha256-HRxIs0G5TZlGOSICON9Yv4H81VQphDn0DuWiKKQtbjg=";
  };
in
{
  xdg.configFile = {
    "swaync/refresh.sh" = {
      source = "${dots}/.config/swaync/refresh.sh";
    };
    "swaync/config.json" = {
      source = "${dots}/.config/swaync/config.json";
    };
  };
  wayland.windowManager.hyprland.settings.exec-once = [ "swaync" ];
}
