{
  description = "Nix dev shell for Elixir & Phoenix";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
  };

  outputs = { self, nixpkgs }:
  let
    system = "x86_64-linux";
    pkgs = import nixpkgs { inherit system; };
    beam = pkgs.beam28Packages;
  in {
    devShells.${system}.default = pkgs.mkShell {
      name = "elixir-phoenix-dev";

      buildInputs = with pkgs; [
        beam.elixir   
        beam.elixir-ls
        nodejs        
        tailwindcss_4 
        # esbuild       
        inotify-tools 
        watchman
        # postgresql
      ];

      # Add 'path: System.get_env("TAILWINDCSS_PATH")' to tailwind config after creating project
      shellHook = ''
        export MIX_ENV=dev
       
        export TAILWINDCSS_PATH="${pkgs.lib.getExe pkgs.tailwindcss_4}"

        echo " Elixir Phoenix dev shell ready"
      '';
    };
  };
}
