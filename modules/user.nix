{ pkgs, config, ... }: {
  programs.fish.enable = true;
  users.users.gradyb = {
    isNormalUser = true;
    description = "grady brown";
    extraGroups = [ "networkmanager" "wheel" "dialout" ];
    shell = pkgs.fish;
  };
}

