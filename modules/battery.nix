{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    bato
    batmon
  ];
}
