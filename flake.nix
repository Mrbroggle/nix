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
  };

  outputs = {
    nixpkgs,
    home-manager,
    nvf,
    ...
  } @ inputs: {
    nixosConfigurations.gradyb-nixos = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = {inherit inputs;};
      modules = [
        nvf.nixosModules.default
        ./configuration.nix
        home-manager.nixosModules.home-manager
        {
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            users.gradyb = import ./home.nix;
            backupFileExtension = "backup";
          };
        }
      ];
    };
  };
}
