_: {
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

  nix.settings = {
    warn-dirty = false;
  };
}
