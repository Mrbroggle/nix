{ pkgs, ... }:
{
  programs.fish.enable = true;
  users.users.gradyb = {
    isNormalUser = true;
    description = "grady brown";
    extraGroups = [
      "networkmanager"
      "wheel"
      "dialout"
      "libvirt"
      "kvm"
    ];
    shell = pkgs.fish;
  };
}
