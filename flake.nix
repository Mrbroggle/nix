{
  description = "A simple NixOS flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    nixos-wsl.url = "github:nix-community/NixOS-WSL/main";
    home-manager = {
      url = "github:nix-community/home-manager";
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
    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      nixpkgs,
      home-manager,
      nixos-hardware,
      nixos-wsl,
      ...
    }@inputs:
    {
      nixosConfigurations = {
        pc-nixos = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = { inherit inputs; };
          modules = [
            ./host/pc.nix
            ./configuration.nix
            inputs.spicetify-nix.nixosModules.default
            inputs.nvf.nixosModules.default
            inputs.stylix.nixosModules.stylix
            home-manager.nixosModules.home-manager
            {
              home-manager = {
                useUserPackages = true;
                users.gradyb = import ./host/pc/home.nix;
                backupFileExtension = "backup";
              };
            }
          ];
        };
        wsl-nixos = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = { inherit inputs; };
          modules = [
            ./host/wsl.nix
            ./configuration.nix
            inputs.nvf.nixosModules.default
            inputs.stylix.nixosModules.stylix
            nixos-wsl.nixosModules.default
            {
              system.stateVersion = "25.05";
              wsl.enable = true;
            }
            home-manager.nixosModules.home-manager
            {
              home-manager = {
                useUserPackages = true;
                users.gradyb = import ./host/wsl/home.nix;
                backupFileExtension = "backup";
              };
            }
          ];
        };
        laptop-nixos = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = { inherit inputs; };
          modules = [
            nixos-hardware.nixosModules.framework-13-7040-amd
            ./host/laptop.nix
            ./configuration.nix
            inputs.spicetify-nix.nixosModules.default
            inputs.nvf.nixosModules.default
            inputs.stylix.nixosModules.stylix
            home-manager.nixosModules.home-manager
            {
              home-manager = {
                useUserPackages = true;
                users.gradyb = import ./host/laptop/home.nix;
                backupFileExtension = "backup";
              };
            }
          ];
        };
        zen-browser = {
          url = "github:0xc000022070/zen-browser-flake";
          inputs.nixpkgs.follows = "nixpkgs";
        };
      };

      outputs =
        {
          nixpkgs,
          home-manager,
          nixos-hardware,
          ...
        }@inputs:
        {
          nixosConfigurations = {
            pc-nixos = nixpkgs.lib.nixosSystem {
              system = "x86_64-linux";
              specialArgs = { inherit inputs; };
              modules = [
                ./host/pc.nix
                ./configuration.nix
                inputs.spicetify-nix.nixosModules.default
                inputs.nvf.nixosModules.default
                inputs.stylix.nixosModules.stylix
                home-manager.nixosModules.home-manager
                {
                  home-manager = {
                    useUserPackages = true;
                    users.gradyb = import ./host/pc/home.nix;
                    backupFileExtension = "backup";
                  };
                }
              ];
            };
            laptop-nixos = nixpkgs.lib.nixosSystem {
              system = "x86_64-linux";
              specialArgs = { inherit inputs; };
              modules = [
                nixos-hardware.nixosModules.framework-13-7040-amd
                ./host/laptop.nix
                ./configuration.nix
                inputs.spicetify-nix.nixosModules.default
                inputs.nvf.nixosModules.default
                inputs.stylix.nixosModules.stylix
                home-manager.nixosModules.home-manager
                {
                  home-manager = {
                    useUserPackages = true;
                    users.gradyb = import ./host/laptop/home.nix;
                    backupFileExtension = "backup";
                  };
                }
              ];
            };
          };
        };
    };
}
