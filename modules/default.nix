{ ... }:
{
  imports = [
    ./editor.nix
    ./locale.nix
    ./networking.nix
    ./user.nix
    ./sound.nix
    ./bluetooth.nix
    ./cli.nix
    ./security.nix
    ./storeConf.nix
    ./stylix.nix
    ./rclone.nix
    ./vulkan.nix
    ./cachix.nix
  ];
}
