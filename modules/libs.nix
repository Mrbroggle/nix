{pkgs, ...}: {
  environment.systemPackages = [
    pkgs.gtk4
    pkgs.gtk3
  ];
}
