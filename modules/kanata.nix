{ lib, config, ... }:
{
  options = {
    kanata.enable = lib.mkOption { default = true; };
  };
  config = lib.mkIf config.kanata.enable {
    boot.kernelModules = [ "uinput" ];

    hardware.uinput.enable = true;

    services.udev.extraRules = ''
      KERNEL=="uinput", MODE="0660", GROUP="uinput", OPTIONS+="static_node=uinput"
    '';

    users.groups.uinput = { };

    systemd.services.kanata-internalKeyboard.serviceConfig = {
      SupplementaryGroups = [
        "input"
        "uinput"
      ];
    };

    services.kanata = {
      enable = true;
      keyboards = {
        internalKeyboard = {
          devices = [
            "/dev/input/by-path/platform-i8042-serio-0-event-kbd"
          ];
          extraDefCfg = "process-unmapped-keys yes";
          config = ''
            (defsrc)
            (deflayermap (base-layer)
              caps esc)
          '';
        };
      };
    };
  };
}
