{
  pkgs,
  lib,
  config,
  inputs,
  ...
}: {
  options = {
    browser.enable = lib.mkOption {default = true;};
  };
  config = lib.mkIf config.browser.enable {
    environment.systemPackages = with pkgs; [
      vivaldi
      inputs.zen-browser.packages."${system}".default
    ];
  };
}
