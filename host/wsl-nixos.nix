{inputs, ...}: {
  wsl.defaultUser = "gradyb";
  imports = [(inputs.import-tree ../modules)];

  battery.enable = false;
  hyprland.enable = false;
  libs.enable = false;
  laptopScreen.enable = false;
  kde6.enable = false;
  browser.enable = false;
  desktopApps.enable = false;
  office.enable = false;
  plymouth.enable = false;
  kanata.enable = false;
  multirotor.enable = false;
  mail.enable = false;
  winapps.enable = false;
  networking.enable = false;
}
