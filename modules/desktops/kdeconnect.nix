{
  lib,
  config,
  ...
}: let
  range = [
    {
      from = 1714;
      to = 1764;
    }
  ];
in {
  options = {
    kdeconnect.enable = lib.mkOption {default = true;};
  };
  config = lib.mkIf config.kdeconnect.enable {
    programs.kdeconnect.enable = true;
    networking.firewall = {
      allowedTCPPortRanges = range;
      allowedUDPPortRanges = range;
    };
  };
}
