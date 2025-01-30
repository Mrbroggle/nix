{ pkgs, config, ...}: {
  security.doas.enable = true;
  security.doas.extraRules = [
    {
	    users = ["gradyb"];

	    keepEnv = true;
	    noPass = true;
    }
  ];
  
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };
  services.openssh.enable = true;


  systemd.services.fprintd = {
    wantedBy = [ "multi-user.target" ];
    serviceConfig.Type = "simple";
  };
  services.fprintd.enable = true;
}
