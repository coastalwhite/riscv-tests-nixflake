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

[Nix Flake]: https://nixos.wiki/wiki/Flakes
[riscv-tests]: https://github.com/riscv-software-src/riscv-tests
[nix installation]: https://nixos.wiki/wiki/Nix_Installation_Guide