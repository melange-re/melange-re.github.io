(lang dune 3.8)

(using melange 0.1)

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
  ocaml
  (reason (>= 3.17))
  ocamlformat
  js_of_ocaml
  (cmarkit :dev)
  (ocaml-lsp-server :dev)
  (odoc :with-doc)))
