{ inputs, ... }:
{
  imports = [ (inputs.import-tree ../modules) ];
  battery.enable = false;
  hyprland.enable = false;
  laptopScreen.enable = false;
  multirotor.enable = false;
}
