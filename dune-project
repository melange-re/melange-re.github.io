(lang dune 3.8)

(using melange 0.1)

(name documentation-site)

(generate_opam_files true)

(authors
 "Antonio Nuno Monteiro <anmonteiro@gmail.com>"
 "Javier Chávarri <javier.chavarri@gmail.com>")

(maintainers
 "Antonio Nuno Monteiro <anmonteiro@gmail.com>"
 "Javier Chávarri <javier.chavarri@gmail.com>")

(license MIT)

(homepage "https://github.com/melange-re/melange-re.github.io")

(bug_reports "https://github.com/melange-re/melange-re.github.io/issues")

(source (github melange-re/melange-re.github.io))

(package
 (name documentation-site)
 (synopsis "Melange documentation site")
 (description "Content for the Melange documentation site")
 (depends
  ocaml
  (reason (>= 3.17))
  ocamlformat
  js_of_ocaml
  (cmarkit :dev)
  (ocaml-lsp-server :dev)
  (odoc :with-doc)))
