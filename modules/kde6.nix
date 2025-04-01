{pkgs, ...}: {
  services = {
    xserver.enable = true;
    displayManager = {
      sddm = {
        enable = true;
        wayland.enable = true;
        settings = {
          Autologin = {
            Session = "plasma.desktop";
            User = "gradyb";
          };
        };
      };
    };
    desktopManager.plasma6.enable = true;
  };
  programs.dconf.enable = true;
  qt.enable = true;
}
