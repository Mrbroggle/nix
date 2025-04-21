{ pkgs, ... }:
let
  dots = pkgs.fetchFromGitHub {
    owner = "Mrbroggle";
    repo = "elifouts-dotfiles";
    rev = "ae208586f7d8aa18f38da7213f8c692139527c1e";
    hash = "sha256-vwkZ3Fdyf5c/SVA+Bx32d5FMfQ9lJgjui4JQLr9BVAM=";
  };
in
{
  programs.waybar.enable = true;
  xdg.configFile."waybar" = {
    source = "${dots}/.config/waybar";
    recursive = true;
  };
  wayland.windowManager.hyprland.settings.exec-once = [ "waybar" ];
}
