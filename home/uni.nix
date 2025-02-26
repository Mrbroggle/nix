{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    zulu23
    zoom-us
    R
    rstudio
  ];
}
