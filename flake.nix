{
  description = "CMSC 330 Flake";

  inputs = {
    nixpkgs.url = "https://flakehub.com/f/NixOS/nixpkgs/0.1.*.tar.gz";
    rust-overlay = {
      url = "github:oxalica/rust-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, rust-overlay }:
    let
      overlays = [
        rust-overlay.overlays.default
        (final: prev: {
          rustToolchain = prev.rust-bin.stable.latest.default.override {
            extensions = [ "rust-src" "rustfmt" "clippy" "rust-analyzer" ];
          };
        })
      ];
      supportedSystems =
        [ "x86_64-linux" "aarch64-linux" "x86_64-darwin" "aarch64-darwin" ];
      forEachSupportedSystem = f:
        nixpkgs.lib.genAttrs supportedSystems
        (system: f { pkgs = import nixpkgs { inherit overlays system; }; });
    in {
      devShells = forEachSupportedSystem ({ pkgs }: {
        default = pkgs.mkShell {
          packages = with pkgs;
            [
              # OCaml
              ocaml
              ocamlformat
              # Rust
              rustToolchain
              # Misc
              graphviz
              gradescope-submit
            ] ++ (with pkgs.ocamlPackages; [
              ocaml-lsp
              dune_3
              utop
              ounit
              qcheck
            ]);
        };
      });
    };
}
