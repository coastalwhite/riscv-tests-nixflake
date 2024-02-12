{
  description = "A very basic flake";

  inputs = {
	  riscv-tests = {
	      url = "git+https://github.com/riscv-software-src/riscv-tests?submodules=1";
	      flake = false;
	  };
      nixpkgs.url = "github:NixOS/nixpkgs";
      flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, riscv-tests, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system: let
        pkgs = import nixpkgs { inherit system; };
        riscv32-toolchain = import nixpkgs {            
            localSystem = system;
            crossSystem.config = "riscv32-none-elf";
        };
        riscv64-toolchain = import nixpkgs {            
            localSystem = system;
            crossSystem.config = "riscv64-none-elf";
        };
        in {
			packages.default = pkgs.stdenv.mkDerivation {
				pname = "riscv-tests";
				version = "0.1";

				src = riscv-tests;

				buildInputs = with pkgs; [
					gnumake
					gnupatch
					autoconf
					riscv32-toolchain.buildPackages.gcc
					riscv64-toolchain.buildPackages.gcc
				];

				patches = [
					./patches/benchmarks/Makefile.patch
					./patches/isa/Makefile.patch
					./patches/mt/Makefile.patch
				];

				configurePhase = ''
				autoconf
				./configure --prefix=$out
				'';

				buildPhase = ''
				mkdir -p $out
				make
				'';

				installPhase = "make install";
			};
	});
}
