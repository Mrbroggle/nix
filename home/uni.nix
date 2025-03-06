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
  /*
    xdg = {
    configFile."rstudio/themes/base16-theme.rstheme".source =
      pkgs.fetchFromGitLab {
        owner = "gb2282006";
        repo = "base16-rthemes";
        rev = "e8f334cd37601178cfea283f02d4e04a59fdbe53";
        hash = "sha256-LBMr+J1sc/khY1BUX9tySMp+i3sw81prctWZmhbwdZs=";
      }
      + "./Tokyo Night Storm.rstheme";
  };
  */
}
