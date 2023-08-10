{
  description = "Description for the project";

  inputs = {
    nixpkgs = {
      url = "github:NixOS/nixpkgs/nixos-23.05";
    };

    flake-utils = {
      url = "github:numtide/flake-utils";
    };

    devshell = {
      url = "github:numtide/devshell";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    nixpkgs,
    flake-utils,
    devshell,
    ...
  }: let
    systems = with flake-utils.lib.system; [
      x86_64-linux
      x86_64-darwin
      aarch64-linux
      aarch64-darwin
    ];
  in
    flake-utils.lib.eachSystem systems (system: let
      pkgs = import nixpkgs {
        inherit system;

        overlays = [
          devshell.overlays.default

          (final: prev: {
            nodejs = prev.nodejs_18;
          })
        ];
      };
    in {
      devShells.default = pkgs.devshell.mkShell {
        env = [
        ];
        packages = with pkgs; [
          poetry

          nodejs
          nodePackages.pnpm
        ];
      };
    });
}
