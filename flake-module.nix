{ self, config, lib, flake-parts-lib, ... }:

let
  inherit (flake-parts-lib)
    mkPerSystemOption;
  inherit (lib)
    types;
in
{
  options = {
    perSystem = mkPerSystemOption
      ({ config, self', inputs', pkgs, system, ... }:
        {
          options = {
            expr = lib.mkOption {
              type = types.raw;
              description = ''
                The expression to be evaluated.

                It must be convertable to a string using `builtins.toString`.
              '';
            };
          };
          config = {
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
              pkgs.writeText "expr" (builtins.toString config.expr + "\n");
          };
        });
  };

}
