{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    (pkgs.rstudioWrapper.override {
      packages = with pkgs.rPackages; [
        ggplot2
        dplyr
        xts
      ];
    })
    (pkgs.rWrapper.override {
      packages = with pkgs.rPackages; [
        ggplot2
        dplyr
        xts
      ];
    })
    zulu23
    zoom-us
  ];
}
