{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.05";
    flake-utils.url = "github:numtide/flake-utils";
  };
  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };
      in
      {
        packages.default = pkgs.stdenv.mkDerivation (finalAttrs: {
          pname = "munit";
          version = "0.2.0";
          src = pkgs.fetchurl {
            url = "https://github.com/nemequ/munit/archive/refs/tags/v${finalAttrs.version}.tar.gz";
            hash = "sha256-WMEvKuCKz8Jw1Hpf8jOAwwCyTX3FPzoj9FJ+ARIUaEQ=";
          };
          installPhase = ''
            mkdir -p $out/include
            cp munit.h munit.c $out/include
          '';
        });
        formatter = pkgs.nixpkgs-fmt;
      }
    );
}
