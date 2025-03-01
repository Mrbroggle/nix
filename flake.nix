{
  description = "A simple NixOS flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    jerry.url = "github:justchokingaround/jerry";
    lobster.url = "github:justchokingaround/lobster";
    hyprland.url = "github:hyprwm/Hyprland";
    nvf = {
      url = "github:notashelf/nvf";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    stylix.url = "github:danth/stylix";
    spicetify-nix.url = "github:Gerg-L/spicetify-nix";
    spicetify-nix.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = {
    nixpkgs,
    home-manager,
    ...
  } @ inputs: {
    nixosConfigurations = {
      pc-nixos = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = {inherit inputs;};
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
        specialArgs = {inherit inputs;};
        modules = [
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
}
