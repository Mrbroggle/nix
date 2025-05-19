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
in
{

  options = {
    uni.enable = lib.mkOption { default = true; };
  };
  config = lib.mkIf config.uni.enable {
    home.packages = with pkgs; [
      zulu23
      zoom-us
      texliveFull
      pandoc
      (rstudioWrapper.override {
        inherit packages;
      })
      (rWrapper.override {
        inherit packages;
      })
    ];
  };
}
