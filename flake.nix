{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";
  };
  outputs = inputs@{ self, nixpkgs, flake-parts, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = nixpkgs.lib.systems.flakeExposed;
      perSystem = { pkgs, lib, ... }:
        let
          expr =
            let contents = lib.attrNames (builtins.readDir ./.);
            in contents;
        in
        {
          packages.default = pkgs.writeShellApplication {
            name = "run";
            text = ''
              function runIt() {
                cat "$(nix build .#expr-output --no-link --print-out-paths)"
              }
              export -f runIt
              ${lib.getExe pkgs.watchexec} -e nix runIt
            '';
          };
          packages.expr-output =
            pkgs.writeText "expr" (builtins.toString expr + "\n");
        };
    };
}
