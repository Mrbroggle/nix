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
  xdg.configFile = {
    "swaync/refresh.sh" = {
      source = "${dots}/.config/swaync/refresh.sh";
    };
    "swaync/config.json" = {
      source = "${dots}/.config/swaync/config.json";
    };
  };
}
