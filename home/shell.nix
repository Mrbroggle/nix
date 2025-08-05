{
  pkgs,
  lib,
  config,
  ...
}: {
  options = {
    shell.enable = lib.mkOption {default = false;};
  };
  config =
    lib.mkIf config.shell.enable {
      home.packages = with pkgs; [
        zoxide
      ];

      programs = {
        eza = {
          enable = true;
          icons = "always";
          enableFishIntegration = true;
        };

        fish = {
          enable = true;
          interactiveShellInit = ''
            direnv hook fish | source
            fastfetch
          '';
          plugins = with pkgs.fishPlugins; [
            {
              name = "grc";
              inherit (grc) src;
            }
            {
              name = "sponge";
              inherit (sponge) src;
            }
            {
              name = "puffer";
              inherit (puffer) src;
            }
            {
              name = "done";
              inherit (done) src;
            }
          ];
          functions = {
            clangComp = "clang++ $argv -g -o $(path basename -E $argv)";
          };
          shellAliases = {
            enc = "doas nvim /home/gradyb/etc/nixos/ ";
            cnc = "cd /home/gradyb/etc/nixos/";
            nrs = "alejandra -q /home/gradyb/etc/nixos/; nh os switch $argv";
            nru = "nh os switch --update ";
            ga = "git add . && git status";
            gc = "git commit";
            gp = "git push";
            gf = "git pull";
            gd = "git clone $argv";
            gs = "git status";
            ls = "eza $argv";
            nsp = "nix-shell -p $argv";
            nrn = "nix run nixpkgs#$argv";
            nr = "nix run $argv";
          };
        };
        starship = {
          enable = true;
          enableFishIntegration = true;
          enableTransience = true;
          ## Stolen tokyo night theme from starship.rs
          settings = {
            nodejs = {
              format = "[[ $symbol ($version) ](fg:#769ff0 bg:#212736)]($style)";
              symbol = "";
              style = "bg:#212736";
            };
            rust = {
              symbol = "";
              style = "bg:#212736";
              format = "[[ $symbol ($version) ](fg:#769ff0 bg:#212736)]($style)";
            };
            php = {
              symbol = "";
              style = "bg:#212736";
              format = "[[ $symbol ($version) ](fg:#769ff0 bg:#212736)]($style)";
            };
            time = {
              disabled = false;
              time_format = "%R";
              style = "bg:#1d2230";
              format = "[[  $time ](fg:#a0a9cb bg:#1d2230)]($style)";
            };
            format = "[░▒▓](#a3aed2)[ 󱄅 ](bg:#a3aed2 fg:#090c0c)[](bg:#769ff0 fg:#a3aed2)$directory[](fg:#769ff0 bg:#394260)$git_branch$git_status[](fg:#394260 bg:#212736)$nodejs$rust$golang$php[](fg:#212736 bg:#1d2230)$time[ ](fg:#1d2230)
$character";
            directory = {
              style = "fg:#e3e5e5 bg:#769ff0";
              format = "[ $path ]($style)";
              truncation_length = 3;
              truncation_symbol = "…/";
              substitutions = {
                Music = " ";
                Pictures = " ";
                Documents = "󰈙 ";
                Downloads = " ";
              };
            };
            git_branch = {
              format = "[[ $symbol $branch ](fg:#769ff0 bg:#394260)]($style)";
              symbol = "";
              style = "bg:#394260";
            };
            git_status = {
              style = "bg:#394260";
              format = "[[($all_status$ahead_behind )](fg:#769ff0 bg:#394260)]($style)";
            };
            golang = {
              format = "[[ $symbol ($version) ](fg:#769ff0 bg:#212736)]($style)";
              symbol = "";
              style = "bg:#212736";
            };
          };
        };
        zoxide = {
          enable = true;
          enableZshIntegration = true;
          options = [
            "--cmd cd"
          ];
        };
      };

      dconf.settings = {
        "org/virt-manager/virt-manager/connections" = {
          autoconnect = ["qemu:///system"];
          uris = ["qemu:///system"];
        };
      };
    };
}
