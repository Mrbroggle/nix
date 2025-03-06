{pkgs, ...}: let
  theme = pkgs.fetchFromGitLab {
    owner = "gb2282006";
    repo = "base16-rthemes";
    rev = "83b367fd80e52c5b3a7d29c1fef358545faba8b2";
    hash = "sha256-BJyAmZthmQZlmoA3qnMuiKMo9hc+4xOCKB6zcBKjysw=";
  };
in {
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
  xdg = {
    configFile."rstudio/themes/base16-theme.rstheme".source = "${theme}/TokyoNightStorm.rstheme";
  };
}
