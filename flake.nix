{
  description = "My NixOS";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    nixos-wsl.url = "github:nix-community/NixOS-WSL/main";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    import-tree.url = "github:vic/import-tree";

    hyprland.url = "github:hyprwm/Hyprland";
    nvf = {
      url = "github:notashelf/nvf";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    stylix.url = "github:danth/stylix";
    # stylix.url = "github:mrbroggle/stylix/rstudio-hm-module";
    #stylix.url = "flake:gradybstylix/rstudio-hm-module";
    spicetify-nix.url = "github:Gerg-L/spicetify-nix";
    spicetify-nix.inputs.nixpkgs.follows = "nixpkgs";
    jerry.url = "github:justchokingaround/jerry";
    lobster.url = "github:justchokingaround/lobster";
    niri.url = "github:sodiboo/niri-flake";
    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    winapps = {
      url = "github:winapps-org/winapps";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixcord = {
      url = "github:kaylorben/nixcord";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    alejandra = {
      url = "github:kamadorueda/alejandra/4.0.0";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nil = {
      url = "github:oxalica/nil#";
    };
    agenix = {
      url = "github:ryantm/agenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    asmfmt = {
      url = "github:Mrbroggle/asmfmt-nix";
    };
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    nixos-hardware,
    nixos-wsl,
    alejandra,
    agenix,
    ...
  } @ inputs: let
    system = "x86_64-linux";
    ## Modifies nixpkgs globally for overlays and unfree

    pkgs = import nixpkgs {
      inherit pkgs;
      inherit system;
      overlays = [
      ];
      config = {
        permittedInsecurePackages = [
          "libxml2-2.13.8"
        ];
        allowUnfree = true;
        allowUnfreePredicate = _: true;
      };
    };

    ## Defines user and hostnames
    defaultUser = "gradyb";
    systems = [
      "laptop-nixos"
      "pc-nixos"
      "wsl-nixos"
      "nas-nixos"
    ];

    ## Modules for specific hosts
    moduleAttrs = {
      laptop-nixos-module = [
        nixos-hardware.nixosModules.framework-13-7040-amd
      ];

      pc-nixos-module = [
      ];

      wsl-nixos-module = [
        nixos-wsl.nixosModules.default

        {
          system.stateVersion = "25.05";
          wsl.enable = true;
        }
      ];

      nas-nixos-module = [];
    };
  in {
    nixosConfigurations = builtins.listToAttrs (
      map (hostName: {
        name = hostName;
        value = nixpkgs.lib.nixosSystem {
          inherit system;
          inherit pkgs;
          specialArgs = {
            inherit inputs system;
            inherit defaultUser hostName;
          };
          ##Imports modules
          modules = [
            (
              ## Function that includes lib for optionals
              {lib, ...}: {
                imports = with inputs;
                  [
                    {_module.args = {inherit inputs;};}

                    {networking.hostName = hostName;}

                    ./configuration.nix
                    ./host/${hostName}.nix
                    ./host/${hostName}/hardware-configuration.nix

                    {
                      home-manager = {
                        extraSpecialArgs = {
                          inherit inputs;
                          inherit pkgs;
                        };
                        useGlobalPkgs = true;
                        useUserPackages = true;

                        users.gradyb = ./host/${hostName}/home.nix;
                        backupFileExtension = "backup";

                        sharedModules = [
                          inputs.nixcord.homeModules.nixcord
                        ];
                      };
                    }

                    home-manager.nixosModules.home-manager
                    nvf.nixosModules.default
                    spicetify-nix.nixosModules.default
                    stylix.nixosModules.stylix
                    agenix.nixosModules.default
                  ]
                  ++ moduleAttrs."${hostName}-module";
              }
            )
          ];
        };
      })
      systems
    );
  };
}
