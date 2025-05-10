{
  pkgs,
  lib,
  config,
  ...
}:
{
  options = {
    mail.enable = lib.mkOption { default = true; };
  };
  config = lib.mkIf config.mail.enable {
    services.protonmail-bridge = {
      enable = true;
      path = with pkgs; [
        pass
        gnome-keyring
      ];
    };
    programs.thunderbird.enable = true;
  };
}
