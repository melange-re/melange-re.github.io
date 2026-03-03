{
  description = "Melange Nix Flake";

  inputs.nixpkgs.url = "github:nix-ocaml/nix-overlays";

  outputs =
    {
      self,
      nixpkgs,
      flake-utils,
    }:
    let
      forAllSystems =
        f:
        nixpkgs.lib.genAttrs nixpkgs.lib.systems.flakeExposed (
          system:
          let
            pkgs = nixpkgs.legacyPackages.${system}.extend (
              self: super: {
                ocamlPackages = super.ocaml-ng.ocamlPackages_5_4.overrideScope (
                  oself: osuper: {
                    cmarkit = osuper.cmarkit.overrideAttrs (_: {
                      src = super.fetchFromGitHub {
                        owner = "dbuenzli";
                        repo = "cmarkit";
                        rev = "6d6f2d289fb336e7d3c15cfe5bbda2c180c95727";
                        hash = "sha256-3VWZJ4p+f/1blsevtXLwFsUD8RrHGI84gehId/twJHc=";
                      };
                      buildPhase = ''
                        runHook preBuild
                        ${oself.topkg.run} build --with-cmdliner false
                        runHook postBuild
                      '';
                    });
                    melange = osuper.melange.overrideAttrs (_: {
                      src = super.fetchFromGitHub {
                        owner = "melange-re";
                        repo = "melange";
                        rev = "0c7fbb6b6734d54e60b7e73d2d696ec31e90a0c8";
                        fetchSubmodules = true;
                        hash = "sha256-HOLqyVCfHfpbJwcrYH1M1jT8Y6v45oFG42SKJVYJm/4=";
                      };
                    });
                    melange-playground =
                      with oself;
                      buildDunePackage {
                        pname = "melange-playground";
                        inherit (melange) src version;
                        nativeBuildInputs = [
                          cppo
                          js_of_ocaml
                        ];
                        propagatedBuildInputs = [
                          js_of_ocaml-compiler
                          melange
                          reason
                          reason-react-ppx
                        ];
                      };
                  }
                );
              }
            );
          in
          f pkgs
        );
    in
    {
      devShells = forAllSystems (
        pkgs:
        let
          python3Packages = pkgs.python3.pkgs.overrideScope (
            pyself: pysuper: {
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
            }
          );
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
            buildInputs =
              with python3Packages;
              [
                mkdocs
                mkdocs-print-site-plugin
                pkgs.yarn
              ]
              ++ (with pkgs.ocamlPackages; [
                reason-react
                reason-react-ppx
                ocamlformat
                js_of_ocaml
                cmarkit
                ocamlformat-lib

              ]);
          };
        }
      );
    };
}
