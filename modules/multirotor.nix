{ pkgs, config, ... }: {
  environment.systemPackages = with pkgs; [
    betaflight-configurator
    inav-configurator
    inav-blackbox-tools
  ];
  services.udev.packages = [
    (pkgs.writeTextDir "lib/udev/rules.d/70-stm32-dfu.rules" ''
      # DFU (Internal bootloader for STM32 and AT32 MCUs)
      SUBSYSTEM=="usb", ATTRS{idVendor}=="2e3c", ATTRS{idProduct}=="df11", TAG+="uaccess"
      SUBSYSTEM=="usb", ATTRS{idVendor}=="0483", ATTRS{idProduct}=="df11", TAG+="uaccess"
    '')
  ];
}
