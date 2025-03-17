{pkgs, ...}: let
  dots = pkgs.fetchFromGitHub {
    owner = "Mrbroggle";
    repo = "elifouts-dotfiles";
    rev = "243e4166c22b2804e586a2ae763c0a982a22ed85";
    hash = "sha256-m3HBZi+dX3wP8zJ4O+kZnqgautPOzSTfNhv6JD3EpSs=";
  };
in {
  programs.waybar.enable = true;
  xdg.configFile."waybar" = {
    source = "${dots}/.config/waybar";
    recursive = true;
  };
}
