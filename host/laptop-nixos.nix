{inputs, ...}: {
  imports = [(inputs.import-tree ../modules)];
  multirotor.enable = false;
  resolve.enable = false;
  secureboot.enable = true;
  laptopScreen.enable = true;
  hyprland.enable = true;
}
