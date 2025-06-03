{
  pkgs,
  lib,
  config,
  ...
}: {
  options = {
    styling.enable = lib.mkOption {default = false;};
  };
  config = lib.mkIf config.styling.enable {
    stylix = {
      enable = true;
      base16Scheme = "${pkgs.base16-schemes}/share/themes/tokyo-night-storm.yaml";
      image = ./wall0.png;
      polarity = "dark";
      autoEnable = true;
      targets = {
        fish.enable = true;
        qt.enable = true;
        gtk.enable = true;
        spicetify.enable = true;
        btop.enable = true;
        neovim.enable = false;
        waybar.enable = true;
        swaync.enable = true;
        rstudio.enable = true;
        nixcord.enable = true;
        ghostty.enable = true;
      };
    };

    xdg.configFile."dolphinrc".text = ''
      [General]
      Version=202
      ViewPropsTimestamp=2025,2,1,12,28,14.355

      [KFileDialog Settings]
      Places Icons Auto-resize=false
      Places Icons Static Size=22

      [MainWindow]
      MenuBar=Disabled
      ToolBarsMovable=Disabled

      [UiSettings]
      ColorScheme=*

      [ViewPropertiesDialog]
      1536x1024 screen: Window-Maximized=true
    '';
  };
}
