# nixid

Like `ghcid -T` but for Nix

`nixid` is a [flake-parts](https://flake.parts/) module for running Nix expressions in a feedback loop, so you can iterate on them in a text editor rather than in `nix repl`.

[![asciicast](https://asciinema.org/a/562438.svg)](https://asciinema.org/a/562438)

## Usage

In an empty directory, run:

```sh
nix flake init -t github:srid/nixid
```

Edit the generated `flake.nix` to make the "expr" option to be whatever Nix expression you are iterating on.

Then run `nix run` to start a feedback loop that evaluates the expression and prints the value whenever it changes.
