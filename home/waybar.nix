{pkgs, ...}: let
  dots = pkgs.fetchFromGitHub {
    owner = "elifouts";
    repo = "Dotfiles";
    rev = "be47bd1e31c698627428a1317829b4b48d402554";
    hash = "sha256-wazJx0dpwRe2632vAwO0pwaXYts3Dly+ygFgQbPdbHI=";
  };
in {
  programs.waybar.enable = true;
  xdg.configFile."waybar" = {
    source = "${dots}/.config/waybar";
    recursive = true;
  };
}
