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
    hyprpanel = {
      url = "github:jas-singhfsu/hyprpanel";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprland.url = "github:hyprwm/Hyprland";
    nvf = {
      url = "github:notashelf/nvf";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    ##stylix.url = "github:danth/stylix";
    stylix.url = "github:mrbroggle/stylix/rstudio-hm-module";
    ##stylix.url = "flake:gradybstylix/rstudio-hm-module";
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
  };

  outputs =
    {
      nixpkgs,
      home-manager,
      nixos-hardware,
      nixos-wsl,
      hyprpanel,
      ...
    }@inputs:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit pkgs;
        inherit system;
        overlays = [
          inputs.hyprpanel.overlay
        ];
        config = {
          allowUnfree = true;
          allowUnfreePredicate = _: true;

        };
      };

      laptop-module = [
        nixos-hardware.nixosModules.framework-13-7040-amd
      ];

      wsl-module = [
        nixos-wsl.nixosModules.default

        {
          system.stateVersion = "25.05";
          wsl.enable = true;
        }
      ];

      pc-module = [

      ];

      defaultUser = "gradyb";
      systems = [
        "laptop-nixos"
        "pc-nixos"
        "wsl-nixos"
      ];

    in
    {
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
            modules = [
              (
                { lib, ... }:
                {
                  imports =
                    [
                      { _module.args = { inherit inputs; }; }
                      ./configuration.nix

                      home-manager.nixosModules.home-manager
                      inputs.spicetify-nix.nixosModules.default
                      inputs.nvf.nixosModules.default
                      inputs.stylix.nixosModules.stylix

                      ./host/${hostName}.nix
                      {
                        home-manager = {
                          useGlobalPkgs = true;
                          useUserPackages = true;
                          users.gradyb = ./host/${hostName}/home.nix;
                          backupFileExtension = "backup";
                        };
                      }
                    ]
                    ++ (lib.optionals (hostName == "laptop-nixos") laptop-module)
                    ++ (lib.optionals (hostName == "pc-nixos") pc-module)
                    ++ (lib.optionals (hostName == "wsl-nixos") wsl-module);
                }
              )
            ];
          };
        }) systems
      );
    };
}
