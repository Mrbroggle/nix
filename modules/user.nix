{
  pkgs,
  lib,
  config,
  ...
}: {
  options = {
    userProfile.enable = lib.mkOption {default = true;};
  };
  config = lib.mkIf config.userProfile.enable {
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
  };
}
