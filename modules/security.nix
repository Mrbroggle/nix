{...}: {
  security = {
    doas.enable = true;
    doas.extraRules = [
      {
        users = ["gradyb"];

        keepEnv = true;
        noPass = true;
      }
    ];
    sudo.extraRules = [
      {
        users = ["gradyb"];
        commands = [
          {
            command = "ALL";
            options = ["SETENV" "NOPASSWD"];
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

  systemd.services.fprintd = {
    wantedBy = ["multi-user.target"];
    serviceConfig.Type = "simple";
  };
  services = {
    fprintd.enable = true;
    openssh.enable = true;
  };
}
