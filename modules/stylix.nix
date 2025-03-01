{pkgs, ...}: {
  stylix = {
    enable = true;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/tokyo-night-dark.yaml";
    image = ../home/wall0.png;
    polarity = "dark";
    autoEnable = true;
    targets = {
      grub = {
        enable = true;
        useImage = true;
      };
      fish.enable = true;
      gtk.enable = true;
      plymouth.enable = true;
      qt.enable = true;
      spicetify.enable = true;
    };
  };
}
