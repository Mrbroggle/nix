{
  lib,
  config,
  ...
}: {
  config = lib.mkIf config.hyprland.enable {
    wayland.windowManager.hyprland.settings = {
      input = {
        sensitivity = "-0.25"; # -1.0 - 1.0, 0 means no modification.
        # kb_layout = "us, au";
        # kb_variant = "colemak,";

        follow_mouse = "1";

        touchpad = {
          disable_while_typing = false;
          natural_scroll = true;
          scroll_factor = "0.4";
        };
      };

      gestures = {
        workspace_swipe = true;
      };
    };
  };
}
