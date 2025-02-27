{
  description = "Melange Nix Flake";

  inputs.nixpkgs.url = "github:nix-ocaml/nix-overlays";

  outputs = { self, nixpkgs, flake-utils }:
    let
      forAllSystems = f: nixpkgs.lib.genAttrs nixpkgs.lib.systems.flakeExposed (system:
        let
          pkgs = nixpkgs.legacyPackages.${system}.extend (self: super: {
            ocamlPackages = super.ocaml-ng.ocamlPackages_5_3.overrideScope (oself: osuper: {
              cmarkit = osuper.cmarkit.overrideAttrs (_: {
                src = super.fetchFromGitHub {
                  owner = "dbuenzli";
                  repo = "cmarkit";
                  rev = "af8930c307957a546ea833bbdabda94a2fa60b4b";
                  hash = "sha256-qwSkmsZXdea4M4Wk/ogZY0NBhOYGBwlA7s0hq7o/3s0=";
                };
              });
              melange = osuper.melange.overrideAttrs (_: {
                src = super.fetchFromGitHub {
                  owner = "melange-re";
                  repo = "melange";
                  rev = "973fa8d80c55ea31e468bae390da2200580ddda6";
                  hash = "sha256-muemErCaWoB3q2GUs99dFrkmo161WMmovtNHtLRxQJ0=";
                  fetchSubmodules = true;
                };
              });
              ppxlib = osuper.ppxlib.overrideAttrs (o: {
                propagatedBuildInputs = o.propagatedBuildInputs ++ [ osuper.stdio ];
              });
            });
          });
        in
        f pkgs);
    in
    {
      devShells = forAllSystems (pkgs:
        let
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
          default = pkgs.mkShell {
            nativeBuildInputs = with pkgs.ocamlPackages; [
              dune
              ocaml
              findlib
              melange
              reason
            ];
            buildInputs = with python3Packages; [
              mkdocs
              mkdocs-print-site-plugin
              pkgs.yarn
            ] ++ (with pkgs.ocamlPackages;  [
              reason-react
              reason-react-ppx
              ocamlformat
              js_of_ocaml
              cmarkit
              ocamlformat-lib

            ]);
          };
        });
    };
}
