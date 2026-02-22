{
  description = "Sway NixOS";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";

    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      ...
    }:
    let
      system = "x86_64.linux";
      homeManagerConfig = {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.users.lauti = import ./home.nix;
        home-manager.backupFileExtension = "backup";
      };
    in
    {
      nixosConfigurations = {
        b360m = nixpkgs.lib.nixosSystem {
          inherit system;
          modules = [
            ./common/configuration.nix
            ./hosts/b360m/configuration.nix
            ./hosts/b360m/hardware-configuration.nix
            home-manager.nixosModules.home-manager
            homeManagerConfig
          ];
        };

        thinkpad = nixpkgs.lib.nixosSystem {
          inherit system;
          modules = [
            ./common/configuration.nix
            ./hosts/thinkpad/configuration.nix
            ./hosts/thinkpad/hardware-configuration.nix
            home-manager.nixosModules.home-manager
            homeManagerConfig
          ];
        };
      };
    };
}
