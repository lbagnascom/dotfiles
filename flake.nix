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

    noctalia-greeter = {
      url = "github:noctalia-dev/noctalia-greeter";
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
      buildHostConfig =
        { hostConfigDir }:
        nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = { inherit inputs; };
          modules = [
            ./common/configuration.nix
            (hostConfigDir + /configuration.nix)
            (hostConfigDir + /hardware-configuration.nix)
            inputs.noctalia-greeter.nixosModules.default
            inputs.noctalia.nixosModules.default
            home-manager.nixosModules.home-manager
            homeManagerConfig
          ];
        };
    in
    {
      nixosConfigurations = {
        b360m = buildHostConfig ./hosts/b360m;
        thinkpad = buildHostConfig ./hosts/thinkpad;
      };
    };
}
