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
            executable = lib.getExe (pkgs.ciscoPacketTracer8.override {
              packetTracerSource = pkgs.fetchurl {
                url = "https://dl.dropbox.com/scl/fi/phgmkyrobg6fh67y4iju6/CiscoPacketTracer822_amd64_signed.deb?rlkey=23pn19vg0cnc1pqb2ncck833d&e=1&st=vhl3x2b8&dl=0";
                hash = "sha256-bNK4iR35LSyti2/cR0gPwIneCFxPP+leuA1UUKKn9y0=";
              };
            });

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
