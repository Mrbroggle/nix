{
  pkgs,
  lib,
  ...
}: {
  stylix = {
    enable = true;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/tokyo-night-storm.yaml";
    image = ./wall0.png;
    polarity = "dark";
    autoEnable = true;
    targets = {
      fish.enable = true;
      qt.enable = true;
      gtk.enable = true;
      spicetify.enable = true;
      btop.enable = true;
      neovim.enable = false;
      waybar.enable = lib.mkForce false;
      swaync.enable = lib.mkForce true;
      rstudio.enable = true;
    };
  };
}
