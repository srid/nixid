{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";
    nixid.url = "github:srid/nixid";
  };
  outputs = inputs@{ self, nixpkgs, flake-parts, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = nixpkgs.lib.systems.flakeExposed;
      imports = [ inputs.nixid.flakeModule ];
      perSystem = { pkgs, lib, ... }: {
        nixid.expr =
          let contents = lib.attrNames (builtins.readDir ./.);
          in contents;
      };
    };
}
