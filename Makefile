project_name = documentation-site

DUNE = opam exec -- dune
SYNTAX ?= ml
BASE ?= unstable
.DEFAULT_GOAL := help

.PHONY: help
help: ## Print this help message
	@echo "List of available make commands";
	@echo "";
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "  \033[36m%-22s\033[0m %s\n", $$1, $$2}';
	@echo "";

.PHONY: create-switch
create-switch: ## Create opam switch
	opam switch create . 5.3.0 -y --deps-only

.PHONY: init
init: create-switch install ## Configure everything to develop this repository in local

.PHONY: install
install: ## Install development dependencies
	opam update
	opam install -y . --deps-only --with-doc
	opam pin -y add $(project_name).dev .
	opam source melange.$$(opam show melange -f version --color never) --dir melange

.PHONY: check-reason
check-reason: ## Checks that Reason syntax snippets are well formed
	$(DUNE) build @re

.PHONY:
update-extracted-code-blocks: ## Updates the code blocks extracted from markdown
	$(DUNE) build @extract-code-blocks --auto-promote || true
	$(DUNE) build @runtest --auto-promote || true

.PHONY: check-extracted-code-blocks
check-extracted-code-blocks: ## Checks that code blocks extracted from markdown are up to date and tests pass
	$(DUNE) build @runtest

.PHONY: test
test: ## Runs @runtest alias
	$(DUNE) build @runtest

.PHONY: clean
clean: ## Clean build artifacts and other generated files
	$(DUNE) clean

.PHONY: format
format: ## Format the codebase with ocamlformat
	$(DUNE) build @fmt --auto-promote

.PHONY: format-check
format-check: ## Checks if format is correct
	$(DUNE) build @fmt

.PHONY: build-playground
build-playground: ## Builds the playground
	$(DUNE) build @playground-assets
	cd playground && yarn && yarn build

.PHONY: build-site
build-site: build-playground build-docs fix-blog-paths ## Builds the whole site (including playground and blog)

.PHONY: build-docs
build-docs: ## Builds the docs (including blog in /{version}/blog/)
	BASE=$(BASE) yarn vitepress build src

.PHONY: fix-blog-paths
fix-blog-paths: ## Post-process blog to move from /{version}/blog/ to /blog/
	node scripts/fix-blog-paths.js $(BASE)

.PHONY: dev
dev: ## Start docs dev server with blog at /blog/ (use BASE= for root paths)
	BASE= yarn vitepress dev src

.PHONY: preview
preview: ## Preview the docs
	yarn vitepress preview src

.PHONY: pull-melange-docs
pull-melange-docs: ## Pull melange docs
	if [ ! -d "melange" ]; then \
		opam source melange.$$(opam show melange -f version --color never) --dir melange; \
	fi
	rm -rf melange/test melange/jscomp/test
	ODOC_SYNTAX=$(SYNTAX) $(DUNE) build @doc-markdown
	rm -rf src/api/$(SYNTAX)
	mkdir -p src/api/$(SYNTAX)
	cp -r _build/default/_doc/_markdown/melange src/api/$(SYNTAX)/
	# Keep only Belt*, Dom*, Node*, Stdlib* files and Js* (but exclude Js_parser)
	find src/api/$(SYNTAX)/melange -type f -name "*.md" ! -name "Js*.md" ! -name "Belt*.md" ! -name "Dom*.md" ! -name "Node*.md" ! -name "Stdlib*.md" ! -name "index.md" -delete
	find src/api/$(SYNTAX)/melange -type f -name "Js_parser*.md" -delete
	# Exclude some docs until https://github.com/melange-re/melange/pull/1619
	find src/api/$(SYNTAX)/melange -type f \( -name "Js-Null.md" -o -name "Js-Undefined.md" -o -name "Js-Re.md" -o -name "Js-Nullable.md" -o -name "Js-Null.md" \) -delete

.PHONY: pull-melange-docs-both
pull-melange-docs-both: ## Pull melange docs for both OCaml and Reason syntax
	make pull-melange-docs SYNTAX="ml"
	make pull-melange-docs SYNTAX="re"
