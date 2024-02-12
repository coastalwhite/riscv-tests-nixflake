# RISC-V Tests Nix Flake

This repository provides a [Nix Flake] that builds and provides all the build
artifacts for the [riscv-tests] repository of unit tests for RISC-V processors.

## Usage

If you have the [Nix package manager installed][nix installation] and you [have
Nix flakes enabled][Nix Flake], then you can simply run the following command in
this a cloned version of this repository.

```bash
nix build
```

If you want to want to add as an input of your own Nix flake, you can add the
following to your flake's inputs.

```nix
riscv-tests.url = "github:coastalwhite/riscv-tests-nixflake";
```

## Example

If you want to make a `devShell` that contains the build artifacts for
[riscv-tests], you can do something similar to the following.

```nix
# flake.nix
{
  description = "RISC-V Tests devShell";

  inputs = {
      nixpkgs.url = "github:NixOS/nixpkgs";
      flake-utils.url = "github:numtide/flake-utils";

      riscv-tests.url = "github:coastalwhite/riscv-tests-nixflake";
  };

  outputs = { self, nixpkgs, flake-utils, riscv-tests }:
    flake-utils.lib.eachDefaultSystem (system: let
        pkgs = import nixpkgs { inherit system; };
        in rec {
            devShells.default = pkgs.mkShell {
				shellHook = ''
                    export RISCV_TESTS="${riscv-tests.packages."${system}".default}"
				'';
			};
        });
}
```

You can then list all the tests:

```bash
nix develop
ls $RISCV_TESTS/share/riscv-tests/isa
```

[Nix Flake]: https://nixos.wiki/wiki/Flakes
[riscv-tests]: https://github.com/riscv-software-src/riscv-tests
[nix installation]: https://nixos.wiki/wiki/Nix_Installation_Guide