{
  description = "A `flake-parts` module for iterating on Nix expressions";
  outputs = { self, ... }: {
    flakeModule = ./flake-module.nix;
    templates.default = {
      description = "A simple flake.nix using nixid";
      path = builtins.path { path = ./example; filter = path: _: baseNameOf path == "flake.nix"; };
    };
  };
}
