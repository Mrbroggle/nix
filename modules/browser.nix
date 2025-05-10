{
  pkgs,
  lib,
  config,
  inputs,
  ...
}:
{
  options = {
    browser.enable = lib.mkOption { default = true; };
  };
  config = lib.mkIf config.browser.enable {
    environment.systemPackages = with pkgs; [
      (vivaldi.override {
        proprietaryCodecs = true;
        enableWidevine = false;
      })
      inputs.zen-browser.packages."${system}".default

    ];
  };
}
