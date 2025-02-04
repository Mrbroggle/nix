{
  pkgs,
  inputs,
  ...
}: {
  environment.systemPackages = with pkgs; [
    nix-output-monitor
    wget
    ffmpeg
    gcc
    git
    cargo
    btop
    meson
    cpio
    cmake
    fastfetch
    inputs.jerry.packages."${pkgs.system}".jerry
    (inputs.lobster.packages."${pkgs.system}".lobster.override {inherit (pkgs) mpv;})
    ueberzugpp
    jq
    chafa
    ani-cli
  ];
}
