{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";
  };
  outputs = inputs@{ self, nixpkgs, flake-parts, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = nixpkgs.lib.systems.flakeExposed;
      imports = [ ./flake-module.nix ];
      perSystem = { pkgs, lib, ... }: {
        expr =
          let contents = lib.attrNames (builtins.readDir ./.);
          in contents;
      };
    };
}
