(lang dune 3.8)

(using melange 0.1)

(generate_opam_files true)

(name documentation-site)

(license MIT)
(maintainers
  "Antonio Nuno Monteiro <anmonteiro@gmail.com>"
  "Javier Chávarri <javier.chavarri@gmail.com>")
(authors
  "Antonio Nuno Monteiro <anmonteiro@gmail.com>"
  "Javier Chávarri <javier.chavarri@gmail.com>")

(source
 (github melange-re/melange-re.github.io))

(package
 (name documentation-site)
 (synopsis "Melange documentation site")
 (description "Content for the Melange documentation site")
 (depends
  ocaml
  dune
  reason
  reason-react
  reason-react-ppx
  ocamlformat
  js_of_ocaml
  (cmarkit :dev)
  (melange :dev)
  (odoc :dev)
  (odoc-parser :dev)
  (melange-playground :dev)
  (ocaml-lsp-server :dev)))
