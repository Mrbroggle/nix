{
  pkgs,
  lib,
  config,
  ...
}:
let
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
  rStudioDesktopItem = pkgs.makeDesktopItem {
    name = "RStudio";
    desktopName = "RStudio";
    exec = "${pkgs.rstudioWrapper}/bin/rstudio";
  };
in
{

  options = {
    uni.enable = lib.mkOption { default = false; };
  };
  config = lib.mkIf config.uni.enable {
    home.packages = with pkgs; [
      zulu23
      zoom-us
      texliveFull
      pandoc
      # rStudioDesktopItem
      (rstudioWrapper.override {
        inherit packages;
      })
      (rWrapper.override {
        inherit packages;
      })
    ];
  };
}
