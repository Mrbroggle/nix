{
  config,
  lib,
  inputs,
  pkgs,
  ...
}:
{
  options = {
    winapps.enable = lib.mkOption { default = true; };
  };
  config = lib.mkIf config.winapps.enable {
    environment.systemPackages = [
      inputs.winapps.packages."${pkgs.system}".winapps
      inputs.winapps.packages."${pkgs.system}".winapps-launcher
    ];
    programs.virt-manager.enable = true;
    users.groups.libvirtd.members = [ "gradyb" ];
    virtualisation = {
      libvirtd = {
        enable = true;
        qemu = {
          package = pkgs.qemu_kvm;
          swtpm.enable = true;
          ovmf = {
            enable = true;
            packages = [
              (pkgs.OVMF.override {
                secureBoot = true;
                tpmSupport = true;
              }).fd
            ];
          };
        };
      };
      spiceUSBRedirection.enable = true;
    };
    environment.etc = {
      "ovmf/edk2-x86_64-secure-code.fd" = {
        source = config.virtualisation.libvirtd.qemu.package + "/share/qemu/edk2-x86_64-secure-code.fd";
      };

      "ovmf/edk2-i386-vars.fd" = {
        source = config.virtualisation.libvirtd.qemu.package + "/share/qemu/edk2-i386-vars.fd";
      };
    };

    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;
  };
}
