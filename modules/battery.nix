{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    bato
    batmon
  ];
  services.tlp.enable = true;
}
