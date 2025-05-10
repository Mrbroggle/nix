{
  pkgs,
  lib,
  config,
  ...
}:
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
  };
}
