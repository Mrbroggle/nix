{ pkgs, lib, ... }: {
  environment.systemPackages = with pkgs; [
    libreoffice-qt
    hunspell
    hunspellDicts.uk_UA
    hunspellDicts.uk_AU
  ];
  }
