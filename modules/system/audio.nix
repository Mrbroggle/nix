{
  pkgs,
  lib,
  config,
  ...
}: {
  options = {
    audio.enable = lib.mkOption {default = true;};
  };
  config = lib.mkIf config.audio.enable {
    security.rtkit.enable = true;
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };
    environment.systemPackages = with pkgs; [
      qpwgraph
      pulseaudio
      pavucontrol
    ];
  };
}
