{pkgs, ...}: {
  programs.fish = {
    enable = true;
    interactiveShellInit = ''

    '';
    plugins = [
      {
        name = "grc";
        src = pkgs.fishPlugins.grc.src;
      }
      {
        name = "sponge";
        src = pkgs.fishPlugins.sponge.src;
      }
      {
        name = "puffer";
        src = pkgs.fishPlugins.puffer.src;
      }
      {
        name = "done";
        src = pkgs.fishPlugins.done.src;
      }
      {
        name = "async-prompt";
        src = pkgs.fishPlugins.async-prompt.src;
      }
    ];
    shellAliases = {
      enc = "doas nvim /etc/nixos/configuration.nix $argv";
      nrs = "nh os switch /home/gradyb/etc/nixos/ $argv";
    };
  };
}
