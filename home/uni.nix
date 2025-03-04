{pkgs, ...}: {
  home.packages = with pkgs; [
    zulu23
    zoom-us
    texliveFull
    (pkgs.rstudioWrapper.override {
      packages = with pkgs.rPackages; [
        rmarkdown
        knitr
        Lock5Data
        magrittr
        stringi
        stringr
        shiny
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
      ];
    })
  ];
  xdg = {
    configFile."rstudio/themes/base16-theme.rstheme".source = ./TokyoNightStorm.rstheme;
  };
}
