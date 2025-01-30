{ pkgs, config, ... }: {
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
  ];
}
