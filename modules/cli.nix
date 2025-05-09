{
  pkgs,
  inputs,
  ...
}:
{
  environment.systemPackages = with pkgs; [
    direnv
    nix-output-monitor
    wget
    ffmpeg
    libsForQt5.ffmpegthumbs
    kdePackages.ffmpegthumbs
    gcc
    git
    cargo
    btop
    meson
    cpio
    cmake
    fastfetch
    unzip
    gzip
    inputs.jerry.packages."${pkgs.system}".jerry
    (inputs.lobster.packages."${pkgs.system}".lobster.override { inherit (pkgs) mpv; })
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
}
