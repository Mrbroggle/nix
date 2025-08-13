{
  lib,
  config,
  ...
}: {
  options = {
    storeConf.enable = lib.mkOption {default = true;};
  };
  config = lib.mkIf config.storeConf.enable {
    nix = {
      optimise.automatic = true;
      optimise.dates = ["07:45"];
      settings.warn-dirty = false;
    };
    programs.nh = {
      enable = true;
      clean = {
        enable = true;
        extraArgs = "--keep 5";
      };
      flake = "/home/gradyb/etc/nixos/";
    };
  };
}
