{pkgs, ...}: {
  home.packages = with pkgs; [
    zulu23
    zoom-us
    R
    rstudio
  ];
}
