{
  description = "Sway NixOS";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

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
