{pkgs, ...}: let
  dots = pkgs.fetchFromGitHub {
    owner = "Mrbroggle";
    repo = "elifouts-dotfiles";
    rev = "9ce9ee8bec51c46d52b6eb264ef2b0c7ac2753d6";
    hash = "sha256-jyY8siZ2j2W3/JmLpCa/yKM91qfAeo0Kfr2DR6e+ebA=";
  };
in {
  programs.waybar.enable = true;
  xdg.configFile."waybar" = {
    source = "${dots}/.config/waybar";
    recursive = true;
  };
}
