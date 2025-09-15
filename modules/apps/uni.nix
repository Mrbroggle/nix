{
  lib,
  config,
  pkgs,
  ...
}: {
  options = {
    uni.enable = lib.mkOption {default = true;};
  };
  config = lib.mkIf config.uni.enable {
    environment.systemPackages = with pkgs; [
      wireshark
      omnissa-horizon-client
    ];
    programs = {
      wireshark = {
        enable = true;
        usbmon.enable = true;
        dumpcap.enable = true;
      };

      ## Jailed due to active CVE also so i dont have to log in
      firejail = {
        enable = true;
        wrappedBinaries = {
          qtspim = {
            executable = lib.getExe pkgs.qtspim;

            desktop = "${pkgs.qtspim}/share/applications/qtspim.desktop";
            extraArgs = [
              "--env=QT_QPA_PLATFORMTHEME=qt5ct"
              "--env=QT_STYLE_OVERRIDE=Fusion"
            ];
          };
          Mars = {
            executable = "${pkgs.mars-mips}/bin/Mars";

            desktop = "${pkgs.mars-mips}/share/applications/mars.desktop";
            extraArgs = [
              "--env=QT_QPA_PLATFORMTHEME=qt5ct"
              "--env=QT_STYLE_OVERRIDE=Fusion"
            ];
          };
          packettracer8 = {
            executable = lib.getExe pkgs.ciscoPacketTracer8;

            desktop = "${pkgs.ciscoPacketTracer8}/share/applications/cisco-pt8.desktop.desktop";
            extraArgs = [
              "--env=QT_SCALE_FACTOR=2"
              "--net=none"
              "--noprofile"
              "--env=QT_QPA_PLATFORMTHEME=qt5ct"
              "--env=QT_STYLE_OVERRIDE=Fusion"
            ];
          };
        };
      };
    };
  };
}
