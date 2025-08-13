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
      # (vivaldi.override {
      #   proprietaryCodecs = true;
      #   enableWidevine = true;
      #   commandLineArgs = "--enable-features=AcceleratedVideoDecodeLinuxGL,VaapiVideoDecoder,VaapiIgnoreDriverChecks,Vulkan,DefaultANGLEVulkan,VulkanFromANGLE";
      # })
      inputs.zen-browser.packages."${system}".default
    ];
  };
}
