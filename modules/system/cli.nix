{
  pkgs,
  lib,
  config,
  inputs,
  ...
}: {
  options = {
    cli.enable = lib.mkOption {default = true;};
  };
  config = lib.mkIf config.cli.enable {
    environment.systemPackages = with pkgs; [
      inputs.alejandra.defaultPackage.x86_64-linux
      inputs.agenix.packages.x86_64-linux.default
      expect
      pre-commit
      direnv
      nix-output-monitor
      wget
      ffmpeg
      libsForQt5.ffmpegthumbs
      unixtools.net-tools
      kdePackages.ffmpegthumbs
      gcc
      git
      cargo
      meson
      cpio
      cmake
      fastfetch
      unzip
      gzip
      inputs.jerry.packages."${pkgs.system}".jerry
      (inputs.lobster.packages."${pkgs.system}".lobster.override {inherit (pkgs) mpv;})
      ueberzugpp
      jq
      chafa
      ani-cli
      grc
      libnotify
      nurl
      ueberzugpp
    ];
    services = {
      fwupd.enable = true;
    };
  };
}
