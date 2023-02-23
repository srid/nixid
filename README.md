# nixid

Like `ghcid -T` but for Nix

## Usage

In an empty directory, run:

```sh
nix flake init -t github:srid/nixid
```

Edit the generated `flake.nix` to make the "expr" option to be whatever Nix expression you are iterating on.

Then run `nix run` to start a feedback loop that evaluates the expression and prints the value whenever it changes.