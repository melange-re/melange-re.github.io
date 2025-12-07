{
  description = "Melange Nix Flake";

  inputs.nixpkgs.url = "github:nix-ocaml/nix-overlays";

  outputs = { self, nixpkgs, flake-utils }:
    let
      forAllSystems = f: nixpkgs.lib.genAttrs nixpkgs.lib.systems.flakeExposed (system:
        let
          pkgs = nixpkgs.legacyPackages.${system}.extend (self: super: {

            ocamlPackages = super.ocaml-ng.ocamlPackages_5_4.overrideScope (oself: osuper: with oself; {
              dune_3 = osuper.dune_3.overrideAttrs (o: {
                src = super.fetchFromGitHub {
                  owner = "ocaml";
                  repo = "dune";
                  rev = "3.21.0_alpha0";
                  hash = "sha256-1uEJIU83zyxApeh1LG8w/+UP2/dGdb/r3V5rMWtZOdc=";
                };
              });
              fs-io = buildDunePackage {
                pname = "fs-io";
                inherit (dune_3) src version;
              };
              top-closure = buildDunePackage {
                pname = "top-closure";
                inherit (dune_3) src version;
              };
              stdune = osuper.stdune.overrideAttrs (o: {
                propagatedBuildInputs = o.propagatedBuildInputs ++ [
                  pp
                  fs-io
                  top-closure
                ];
              });

              cmarkit = osuper.cmarkit.overrideAttrs (_: {
                src = super.fetchFromGitHub {
                  owner = "dbuenzli";
                  repo = "cmarkit";
                  rev = "6d6f2d289fb336e7d3c15cfe5bbda2c180c95727";
                  hash = "sha256-3VWZJ4p+f/1blsevtXLwFsUD8RrHGI84gehId/twJHc=";
                };
                # propagatedBuildInputs = (o.propagatedBuildInputs or [ ]) ++ (with oself; [ cmdliner ]);
                buildPhase = ''
                  runHook preBuild
                  ${topkg.run} build --with-cmdliner false
                  runHook postBuild
                '';
              });
              melange-playground = buildDunePackage {
                pname = "melange-playground";
                inherit (melange) src version;
                # nativeBuildInputs = [ cppo reason ];
                # propagatedBuildInputs = [ melange reason ];
                nativeBuildInputs = [ cppo js_of_ocaml ]; # nodejs menhir 
                propagatedBuildInputs = [ js_of_ocaml-compiler melange reason reason-react-ppx ];

              };
              melange = osuper.melange.overrideAttrs (_: {
                src = super.fetchFromGitHub {
                  owner = "melange-re";
                  repo = "melange";
                  rev = "6.0.1-54";
                  hash = "sha256-CvIIRYW7VfUxNOMCgltUAQcmwM4sB0eFYm/70dQO/i8=";
                  fetchSubmodules = true;
                };
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
              version = "2.8";
              pyproject = true;
              build-system = [ pyself.setuptools ];
              src = pkgs.fetchFromGitHub {
                owner = "timvink";
                repo = "mkdocs-print-site-plugin";
                rev = "v${version}";
                hash = "sha256-ItBpovQ6emFYrlcVlCPjc21aInX/5hvk14QpkAdBSAA=";
              };
              propagatedBuildInputs = with pyself; [
                setuptools-scm
                mkdocs-material
              ];
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
              melange-playground
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
