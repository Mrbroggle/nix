{
  lib,
  config,
  ...
}: {
  options = {
    security.enable = lib.mkOption {default = false;};
  };
  config = lib.mkIf config.security.enable {
    services.opensnitch-ui.enable = true;
  };
}
