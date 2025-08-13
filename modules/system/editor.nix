{
  pkgs,
  lib,
  config,
  inputs,
  ...
}: let
  asmfmt-git = inputs.asmfmt.packages.x86_64-linux.default;
  mips-asm-lsp = let
    pname = "mips-asm-lsp";
    version = "0.10.1";
  in
    pkgs.rustPlatform.buildRustPackage {
      inherit pname version;

      src = pkgs.fetchFromGitHub {
        owner = "bergercookie";
        repo = "asm-lsp";
        rev = "ba39d0155216fc7d6f011522a849126d3f9f461b";
        hash = "sha256-qO9PF7VKZUe+nd3e6eQhsutvM6CqA7u6qDm0+yleIy4=";
      };

      nativeBuildInputs = [pkgs.pkg-config];

      buildInputs = lib.optionals (!pkgs.stdenv.hostPlatform.isDarwin) [pkgs.openssl];

      cargoHash = "sha256-4GbKT8+TMf2o563blj8lnZTD7Lc+z9yW11TfxYzDSg4=";

      # tests expect ~/.cache/asm-lsp to be writable
      preCheck = ''
        export HOME=$(mktemp -d)
      '';

      # Prepend the default config to Cargo.toml
      postPatch = ''
            cat <<EOF > Cargo.toml.new
        [default_config]
        assembler = "mars"
        instruction_set = "mips"
        EOF
            cat Cargo.toml >> Cargo.toml.new
            mv Cargo.toml.new Cargo.toml
      '';

      meta = {
        description = "Language server for NASM/GAS/GO Assembly";
        homepage = "https://github.com/bergercookie/asm-lsp";
        license = lib.licenses.bsd2;
        maintainers = with lib.maintainers; [
          NotAShelf
          CaiqueFigueiredo
        ];
        mainProgram = "asm-lsp";
        platforms = lib.platforms.unix;
      };
    };

  asmfmt-config = ''
    use_tabs: true
  '';
in {
  options = {
    editor.enable = lib.mkOption {default = true;};
  };
  config = lib.mkIf config.editor.enable {
    programs.neovim = {
      enable = true;
      defaultEditor = true;
    };
    environment.systemPackages = with pkgs; [
      fzf
      asmfmt-git
      ripgrep
      lazygit
      fd
      glsl_analyzer
      gcc
      clang
      lldb
    ];
    programs.nvf = {
      enable = true;
      settings = {
        vim = {
          clipboard = {
            enable = true;
            providers.wl-copy.enable = true;
            registers = "unnamedplus";
          };
          extraPlugins = with pkgs.vimPlugins; {
            stay-centered = {
              package = stay-centered-nvim;
              setup = "require('stay-centered').setup({
              disable_on_mouse = true,
            })";
            };
          };
          luaConfigRC.glsl-lsp = ''
            require'lspconfig'.glsl_analyzer.setup{}
          '';
          viAlias = true;
          vimAlias = true;

          formatter = {
            conform-nvim = {
              enable = true;
              setupOpts = {
                formatter = {
                  asmfmt = {
                    command = lib.getExe asmfmt-git + " --config ${asmfmt-config}";
                  };
                };
                formatters_by_ft = {
                  asm = ["asmfmt"];
                  s = ["asmfmt"];
                };
                format_on_save = {
                  _type = "lua-inline";
                  expr = ''
                    function()
                      if not vim.g.formatsave or vim.b.disableFormatSave then
                        return
                      else
                        return {["lsp_format"] = "fallback"}
                      end
                    end
                  '';
                };
              };
            };
          };

          debugMode = {
            enable = false;
            level = 16;
            logFile = "/tmp/nvim.log";
          };
          options = {
            scrolloff = 20;
            tabstop = 2;
            shiftwidth = 2;
          };
          spellcheck = {
            enable = true;
          };
          keymaps = [
            {
              key = "<leader>e";
              mode = ["n"];
              action = ":Neotree toggle<CR>";
              silent = true;
              desc = "Toggle Neo-Tree";
            }
            {
              key = "<C-BS>";
              mode = ["i"];
              action = "<C-W>";
              silent = true;
              desc = "Ctrl backspace back <3";
            }
            {
              key = "<leader><leader>";
              mode = ["n"];
              action = ":Telescope live_grep<CR>";
              silent = true;
              desc = "double space grep";
            }
          ];

          lsp = {
            enable = true;
            formatOnSave = true;
            lspkind.enable = false;
            lightbulb.enable = true;
            lspsaga.enable = false;
            trouble.enable = true;
            lspSignature.enable = true;
            otter-nvim.enable = true;
            nvim-docs-view.enable = true;
          };

          debugger = {
            nvim-dap = {
              enable = true;
              ui.enable = true;
            };
          };

          # This section does not include a comprehensive list of available language modules.
          # To list all available language module options, please visit the nvf manual.
          languages = {
            enableFormat = true;
            enableTreesitter = true;
            enableExtraDiagnostics = true;

            # Languages that will be supported in default and maximal configurations.
            nix = {
              enable = true;
              treesitter.enable = true;
              lsp = {
                enable = true;
                package = inputs.nil.packages.x86_64-linux.default;
              };
              format = {
                type = "alejandra";
                package = inputs.alejandra.defaultPackage.x86_64-linux;
              };
              extraDiagnostics = {
                enable = true;
                types = [
                  "statix"
                ];
              };
            };
            markdown.enable = true;

            # Languages that are enabled in the maximal configuration.
            bash.enable = true;
            clang = {
              enable = true;
              dap.enable = true;
            };
            css.enable = true;
            html.enable = true;
            sql.enable = true;
            java.enable = true;
            kotlin.enable = true;
            ts.enable = true;
            go.enable = true;
            lua.enable = true;
            zig.enable = true;
            python.enable = true;
            typst.enable = true;
            rust = {
              enable = true;
              crates.enable = true;
            };

            # Language modules that are not as common.
            assembly = {
              enable = true;
              lsp.package = mips-asm-lsp;
            };
            astro.enable = false;
            nu.enable = false;
            csharp.enable = true;
            julia.enable = false;
            vala.enable = false;
            scala.enable = false;
            r.enable = true;
            gleam.enable = false;
            dart.enable = false;
            ocaml.enable = false;
            elixir.enable = false;
            haskell.enable = false;
            ruby.enable = false;

            tailwind.enable = true;
            svelte.enable = true;

            # Nim LSP is broken on Darwin and therefore
            # should be disabled by default. Users may still enable
            # `vim.languages.vim` to enable it, this does not restrict
            # that.
            # See: <https://github.com/PMunch/nimlsp/issues/178#issue-2128106096>
            nim.enable = false;
          };

          visuals = {
            nvim-scrollbar.enable = true;
            nvim-web-devicons.enable = true;
            nvim-cursorline.enable = true;
            cinnamon-nvim.enable = true;
            fidget-nvim.enable = true;

            highlight-undo.enable = true;
            indent-blankline.enable = true;

            # Fun
            cellular-automaton.enable = false;
          };

          statusline = {
            lualine = {
              enable = true;
              theme = "base16";
            };
          };

          theme = {
            enable = true;
            name = "base16";
            /*
            base16-colors = {
                       base00 = "#24283b";
                       base01 = "#16161e";
                       base02 = "#343a52";
                       base03 = "#444b6a";
                       base04 = "#787c99";
                       base05 = "#a9b1d6";
                       base06 = "#cbccd1";
                       base07 = "#d5d6db";
                       base08 = "#c0caf5";
                       base09 = "#a9b1d6";
                       base0A = "#0db9d7";
                       base0B = "#9ece6a";
                       base0C = "#b4f9f8";
                       base0D = "#2ac3de";
                       base0E = "#bb9af7";
                       base0F = "#f7768e";
                     };
            */
            transparent = false;
          };

          autopairs.nvim-autopairs.enable = true;

          autocomplete.nvim-cmp.enable = true;
          snippets.luasnip.enable = true;

          filetree = {
            neo-tree = {
              enable = true;
            };
          };

          tabline = {
            nvimBufferline.enable = true;
          };

          treesitter.context.enable = false;

          binds = {
            whichKey.enable = true;
            cheatsheet.enable = true;
          };

          telescope.enable = true;

          git = {
            enable = true;
            gitsigns.enable = true;
            gitsigns.codeActions.enable = false; # throws an annoying debug message
          };

          minimap = {
            minimap-vim.enable = false;
            codewindow.enable = true; # lighter, faster, and uses lua for configuration
          };

          dashboard = {
            dashboard-nvim.enable = false;
            alpha.enable = true;
          };

          notify = {
            nvim-notify.enable = true;
          };

          projects = {
            project-nvim.enable = true;
          };

          utility = {
            ccc.enable = false;
            vim-wakatime.enable = false;
            icon-picker.enable = true;
            surround.enable = true;
            diffview-nvim.enable = true;
            yanky-nvim = {
              enable = true;
              setupOpts = {
                ring.storage = "sqlite";
              };
            };
            motion = {
              hop.enable = true;
              leap.enable = true;
              precognition.enable = true;
            };

            images = {
              image-nvim.enable = false;
            };
          };

          notes = {
            obsidian.enable = false; # FIXME: neovim fails to build if obsidian is enabled
            neorg.enable = false;
            orgmode.enable = false;
            mind-nvim.enable = true;
            todo-comments.enable = true;
          };

          terminal = {
            toggleterm = {
              enable = true;
              lazygit.enable = true;
            };
          };

          ui = {
            borders.enable = true;
            noice.enable = true;
            colorizer.enable = true;
            modes-nvim.enable = false; # the theme looks terrible with catppuccin
            illuminate.enable = true;
            breadcrumbs = {
              enable = true;
              navbuddy.enable = true;
            };
            smartcolumn = {
              enable = true;
              setupOpts.custom_colorcolumn = {
                # this is a freeform module, it's `buftype = int;` for configuring column position
                nix = "110";
                ruby = "120";
                java = "130";
                go = [
                  "90"
                  "130"
                ];
              };
            };
            fastaction.enable = true;
          };

          assistant = {
            chatgpt.enable = false;
            copilot = {
              enable = false;
              cmp.enable = true;
            };
          };

          session = {
            nvim-session-manager.enable = false;
          };

          gestures = {
            gesture-nvim.enable = false;
          };

          comments = {
            comment-nvim.enable = true;
          };

          presence = {
            neocord.enable = false;
          };
        };
      };
    };
  };
}
