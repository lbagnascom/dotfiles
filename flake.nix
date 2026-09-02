{
  description = "Sway NixOS";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-26.05";

    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    noctalia = {
      url = "github:noctalia-dev/noctalia";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      ...
    }@inputs:
    let
      system = "x86_64-linux";
      homeManagerConfig = {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.users.lauti = import ./home.nix;
        home-manager.backupFileExtension = "backup";
        home-manager.extraSpecialArgs = { inherit inputs; };
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
