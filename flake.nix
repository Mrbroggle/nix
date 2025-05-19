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
      ## Modifies nixpkgs globally for overlays and unfree
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

      ## Defines user and hostnames
      defaultUser = "gradyb";
      systems = [
        "laptop-nixos"
        "pc-nixos"
        "wsl-nixos"
        "nas-nixos"
      ];

      ## Modules for specific hosts
      laptop-module = [
        nixos-hardware.nixosModules.framework-13-7040-amd
      ];

      pc-module = [
      ];

      wsl-module = [
        nixos-wsl.nixosModules.default

        {
          system.stateVersion = "25.05";
          wsl.enable = true;
        }
      ];

      nas-module = [ ];
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
            ##Imports modules
            modules = [
              (
                ## Function that includes lib for optionals
                { lib, ... }:
                {
                  imports =
                    [
                      { _module.args = { inherit inputs; }; }
                      ./configuration.nix

                      ## Sets hostname
                      { networking.hostName = hostName; }
                      ## Imports modules used in everything
                      home-manager.nixosModules.home-manager
                      inputs.nvf.nixosModules.default
                      inputs.spicetify-nix.nixosModules.default
                      inputs.stylix.nixosModules.stylix

                      ## Imports files from hosts/
                      ./host/${hostName}.nix
                      ./host/${hostName}/hardware-configuration.nix
                      ## Imports home-manager from hosts/
                      ## additionally useGlobalPkgs is defined, this is why we modify nixpkgs in the let block
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
                        };
                      }
                    ]
                    ##optionally adds modules based of hostname
                    ++ (lib.optionals (hostName == "laptop-nixos") laptop-module)
                    ++ (lib.optionals (hostName == "pc-nixos") pc-module)
                    ++ (lib.optionals (hostName == "wsl-nixos") wsl-module)
                    ++ (lib.optionals (hostName == "nas-nixos") nas-module);
                }
              )
            ];
          };
        }) systems
      );
    };
}
