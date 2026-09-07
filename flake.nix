{
  description = "Sway NixOS";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-26.05";

    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
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
      system = "x86_64-linux";
      buildHostConfig =
        hostConfigDir:
        nixpkgs.lib.nixosSystem {
          inherit system;
          modules = [
            ./common/configuration.nix
            (hostConfigDir + /configuration.nix)
            (hostConfigDir + /hardware-configuration.nix)
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.lauti = import ./home.nix;
              home-manager.backupFileExtension = "backup";
            }
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
