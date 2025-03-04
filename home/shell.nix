{pkgs, ...}: {
  programs = {
    eza = {
      enable = true;
      icons = "always";
      enableFishIntegration = true;
    };
    thefuck.enable = true;
    fish = {
      enable = true;
      interactiveShellInit = ''
        direnv hook fish | source

                fastfetch
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
      ];
      shellAliases = {
        enc = "doas nvim /etc/nixos/ ";
        cnc = "cd /etc/nixos/";
        nrs = "nh os switch /home/gradyb/etc/nixos/ $argv";
        ga = "git add .";
        gc = "git commit";
        gp = "git push";
        gd = "git clone $argv";
        ani = "ani-cli $argv";
        anid = "ani-cli -d $argv";
        ls = "eza $argv";
        rs = "rstudio & disown & exit";
      };
    };
  };
}
