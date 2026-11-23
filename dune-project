(lang dune 3.21)

(using melange 1.0)

(name documentation-site)

(generate_opam_files true)

(source (github melange-re/melange-re.github.io))
(license MIT)
(maintainers
 "Antonio Nuno Monteiro <anmonteiro@gmail.com>"
 "Javier Chávarri <javier.chavarri@gmail.com>")
(authors
 "Antonio Nuno Monteiro <anmonteiro@gmail.com>"
 "Javier Chávarri <javier.chavarri@gmail.com>")

(homepage "https://github.com/melange-re/melange-re.github.io")

(bug_reports "https://github.com/melange-re/melange-re.github.io/issues")

(package
 (name documentation-site)
 (synopsis "Melange documentation site")
 (description "Content for the Melange documentation site")
 (depends
  (ocaml (and (>= 5.5) (< 5.6)))
  (melange (= 7.0.1-55))
  (reason (= 3.18.0))
  (reason-to-mlx (= 0.1.0))
  (ocamlfind :build)
  ocamlformat
  (ocamlformat-mlx-lib (= 0.29.0.2))
  (ppxlib (>= 0.38.0))
  js_of_ocaml
  (cmarkit :dev)
  (ocaml-lsp-server :dev)
  (odoc :with-doc)))
