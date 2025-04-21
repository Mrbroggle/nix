{ ... }:
{
  nix = {
    optimise.automatic = true;
    optimise.dates = [ "07:45" ];
    #  gc = {
    #    automatic = true;
    #    dates = "weekly";
    #    options = "--delete-older-than 30d";
    #  };
  };
  programs.nh = {
    enable = true;
    clean.enable = true;
    clean.extraArgs = "--keep-since 4d --keep 3";
    flake = "/home/gradyb/etc/nixos/";
  };
}
