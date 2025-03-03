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
  xdg.configFile."rstudio/themes/base16-tokyo-night.rstheme".source =
    pkgs.fetchFromGitLab {
      owner = "gb2282006";
      repo = "base16-tokyo-night-dark-rstheme";
      rev = "20aaa8241a9c8a3cad22e03c6ad06126fcc81c5d";
      hash = "sha256-c3hNiz7LIwBB4+xYHtBjEvra/1uiynRNlTLuMv/sYI0=";
    }
    + "/base16-tokyo-night.rstheme";
}
