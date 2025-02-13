{pkgs, ...}: {
  stylix = {
    enable = true;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/ayu-dark.yaml";
    image = ../home/wall0.png;
    polarity = "dark";
    targets = {
      grub = {
        enable = true;
        useImage = true;
      };
      fish.enable = true;
      gtk.enable = true;
      plymouth.enable = true;
      qt.enable = true;
      regreet.enable = true;
      spicetify.enable = true;
    };
  };
}
