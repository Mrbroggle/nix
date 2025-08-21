{
  pkgs,
  lib,
  config,
  ...
}: {
  options = {
    secureboot.enable = lib.mkOption {default = false;};
  };
  config = lib.mkIf config.secureboot.enable {
    boot.loader.systemd-boot.enable = lib.mkForce false;
    boot.lanzaboote = {
      enable = true;
      pkiBundle = "/var/lib/sbctl";
    };

    environment.systemPackages = [
      pkgs.sbctl
    ];
  };
}
