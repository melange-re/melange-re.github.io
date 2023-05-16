{
  description = "Melange Nix Flake";

  inputs = {
    flake-utils.url = "github:numtide/flake-utils";
    nixpkgs = {
      url = "github:nix-ocaml/nix-overlays";
      inputs.flake-utils.follows = "flake-utils";
    };
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages."${system}";
        python3Packages = pkgs.python3.pkgs.overrideScope (pyself: pysuper: {
          mkdocs-print-site-plugin = pyself.buildPythonPackage rec {
            pname = "mkdocs-print-site-plugin";
            version = "2.3.4";

            src = pkgs.fetchFromGitHub {
              owner = "timvink";
              repo = "mkdocs-print-site-plugin";
              rev = "v${version}";
              hash = "sha256-hcOSRDGNzm8upFO2l5cNqW/Q2PUK1US1zwVGzRaVI7E=";
            };
            propagatedBuildInputs = with pyself; [ mkdocs-material ];
            checkInputs = with pyself; [ pytest ];
          };
        });
      in

      {
        devShells = {
          default = pkgs.mkShell {
            buildInputs = with python3Packages; [
              mkdocs
              mkdocs-print-site-plugin
            ];
          };
        };
      });
}
