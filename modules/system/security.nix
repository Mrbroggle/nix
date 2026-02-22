{
  lib,
  config,
  pkgs,
  ...
}: {
  options = {
    security.enable = lib.mkOption {default = true;};
  };
  config = lib.mkIf config.security.enable {
    security = {
      doas = {
        enable = true;
        extraRules = [
          {
            users = ["gradyb"];
            keepEnv = true;
            persist = true;
          }
        ];
      };
      sudo.extraRules = [
        {
          users = ["gradyb"];
          commands = [
            {
              command = "ALL";
              options = [
              ];
            }
          ];
        }
      ];

      pam = {
        u2f = {
          enable = true;
          settings = {
            interactive = true;
            cue = true;

            origin = "pam://yubi";
            authfile =
              pkgs.writeText "u2f-mappings" (lib.concatStrings [
                ]);
          };
        };
        services = {
          login.enableGnomeKeyring = true;
          /*
          fprintd.enableGnomeKeyring = true;
          sddm.text = lib.mkForce (
            lib.strings.concatLines (
              builtins.filter (x: (lib.strings.hasPrefix "auth " x) && (!lib.strings.hasInfix "fprintd" x)) (
                lib.strings.splitString "\n"
                config.security.pam.services.login.text
              )
            )
            + ''

              account   include   login
              password  substack  login
              session   include   login
            ''
          );
          */
        };
      };
    };

    environment.systemPackages = with pkgs; [
      yubikey-manager
      cryptsetup
    ];
    programs = {
      gnupg.agent = {
        enable = true;
        enableSSHSupport = true;
      };
    };
    nix.settings.trusted-users = [
      "root"
      "gradyb"
    ];
    /*
    systemd.services.fprintd = {
      wantedBy = ["multi-user.target"];
      serviceConfig.Type = "simple";
    };
    */
    services = {
      gnome.gnome-keyring.enable = true;
      opensnitch.enable = true;
      openssh.enable = true;
      pcscd.enable = true;
      udev.packages = [pkgs.yubikey-personalization];
    };
  };
}
