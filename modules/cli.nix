{ pkgs, config, inputs, ... }: {
  environment.systemPackages = with pkgs; [
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
    inputs.lobster.packages."${pkgs.system}".lobster
    ueberzugpp
    jq
    chafa
    ani-cli
  ];
}
