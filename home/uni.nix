{ pkgs, ... }:
{

  home.packages = with pkgs; [
    zulu23
    zoom-us
    texliveFull
    pandoc
    (pkgs.rstudioWrapper.override {
      packages = with pkgs.rPackages; [
        rmarkdown
        knitr
        Lock5Data
        magrittr
        stringi
        stringr
        shiny
        png
        reticulate
      ];
    })
    (pkgs.rWrapper.override {
      packages = with pkgs.rPackages; [
        rmarkdown
        knitr
        Lock5Data
        magrittr
        stringi
        stringr
        shiny
        png
        reticulate
      ];
    })
  ];
}
