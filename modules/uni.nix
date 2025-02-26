{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    rstudio
    R
    zulu23
    zoom-us
  ];
}
