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
        qt = {
          enable = true;
          platform = "qtct";
        };
        kde.enable = true;
        gtk.enable = true;
        spicetify.enable = true;
        btop.enable = true;
        neovim.enable = false;
        waybar.enable = true;
        swaync.enable = true;
        rstudio.enable = true;
        nixcord = {
          enable = true;
          extraCss = ''
            :root {
              --base00: #${config.lib.stylix.colors.base01} !important;
              --base01: #${config.lib.stylix.colors.base00} !important;
            }
          '';
        };
        ghostty.enable = true;
      };
    };

    xdg.configFile."kdeglobals".text = ''
      [General]
      TerminalApplication=ghostty

      [KFileDialog Settings]
      Places Icons Auto-resize=false
      Places Icons Static Size=22

      [MainWindow]
      MenuBar=Disabled
      ToolBarsMovable=Disabled

      [UiSettings]
      ColorScheme=*

    '';
  };
}
