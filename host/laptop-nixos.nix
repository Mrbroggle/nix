{inputs, ...}: {
  imports = [(inputs.import-tree ../modules)];
  kde6.enable = false;
  multirotor.enable = false;
  resolve.enable = false;
  secureboot.enable = true;
}
