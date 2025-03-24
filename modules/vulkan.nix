{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    vulkan-headers
    vulkan-tools
    vulkan-extension-layer
    vulkan-validation-layers
    vulkan-memory-allocator
    vulkan-utility-libraries
    vulkan-caps-viewer
  ];
}
