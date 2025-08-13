{
  lib,
  config,
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
            noPass = true;
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
                "SETENV"
                "NOPASSWD"
              ];
            }
          ];
        }
      ];

      pam.services.fprintd.enableGnomeKeyring = true;
    };
    programs.gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };
    nix.settings.trusted-users = [
      "root"
      "gradyb"
    ];

    systemd.services.fprintd = {
      wantedBy = ["multi-user.target"];
      serviceConfig.Type = "simple";
    };
    services = {
      opensnitch.enable = true;
      openssh.enable = true;
      passSecretService.enable = true;
    };
  };
}
