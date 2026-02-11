{
  description = "Sway NixOS";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

<<<<<<< HEAD
  outputs = { self, nixpkgs, home-manager, ... }:
    let 
      mySystem = "x86_64.linux";
      homeManager = {
        home-manager = {
          useGlobalPkgs = true;
          useUserPackages = true;
          users.lauti = import ./home.nix;
          backupFileExtension = "backup";
        };
=======
  outputs = { nixpkgs, home-manager, ... } @ inputs: {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      system = "x86_64.linux";
      modules = [
          ./configuration.nix
          home-manager.nixosModules.home-manager {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              users.lauti = import ./home.nix;
              backupFileExtension = "backup";
            };
          }
        ];
>>>>>>> origin/master
      };
    in {
      nixosConfigurations = {
        b360m = nixpkgs.lib.nixosSystem {
          system = mySystem;
          modules = [
            ./hosts/b360m/configuration.nix
            home-manager.nixosModules.home-manager homeManager 
          ];
        };
    
        thinkpad = nixpkgs.lib.nixosSystem {
          system = mySystem;
          modules = [
            ./hosts/thinkpad/configuration.nix
            home-manager.nixosModules.home-manager homeManager
          ];
        };
    };
  };
}
