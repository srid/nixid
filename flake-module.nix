{ self, config, lib, flake-parts-lib, ... }:

let
  inherit (flake-parts-lib)
    mkPerSystemOption;
  inherit (lib)
    types;
in
{
  options = {
    perSystem = mkPerSystemOption ({ config, self', inputs', pkgs, system, ... }: {
      options = {
        nixid = lib.mkOption {
          default = { };
          type = types.submodule {
            options = {
              expr = lib.mkOption {
                type = types.raw;
                description = ''
                  The expression to be evaluated.

                  It must be convertable to a string using `builtins.toString`.
                '';
              };
              show-trace = lib.mkOption {
                type = types.bool;
                default = false;
                description = ''
                  Whether to show the stack trace.
                '';
              };
            };
          };
        };

      };
      config = {
        packages.default = pkgs.writeShellApplication {
          name = "run";
          text = ''
            function runIt() {
              cat "$(nix build .#expr-output ${if config.nixid.show-trace then "--show-trace" else ""} --no-link --print-out-paths)"
            }
            export -f runIt
            ${lib.getExe pkgs.watchexec} -e nix runIt
          '';
        };
        packages.expr-output =
          pkgs.writeText "expr" (builtins.toString config.nixid.expr + "\n");
      };
    });
  };

}
