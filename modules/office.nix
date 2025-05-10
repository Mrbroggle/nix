{
  pkgs,
  lib,
  config,
  ...
}:
{
  options = {
    office.enable = lib.mkOption { default = true; };
  };
  config = lib.mkIf config.office.enable {
    environment.systemPackages = with pkgs; [
      libreoffice-qt
      hunspell
      hunspellDicts.en_US
      hunspellDicts.en_AU
      zotero
    ];
    # Printer
    services.printing.enable = true;
    services.avahi = {
      enable = true;
      nssmdns4 = true;
      openFirewall = true;
    };
  };
}
