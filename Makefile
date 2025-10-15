project_name = documentation-site

DUNE = opam exec -- dune
SYNTAX ?= ml
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
check-extracted-code-blocks: update-extracted-code-blocks ## Checks that code blocks extracted from markdown have been updated to latest
	@status=$$(git status --porcelain); \
	if [ ! -z "$${status}" ]; \
	then \
		echo "Error - working directory is dirty. Make sure the auto-generated tests are updated ('make update-extracted-code-blocks')"; \
		exit 1; \
	fi

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
build-site: build-playground ## Builds the whole site (including playground)
	yarn && make build-docs

.PHONY: build-docs
build-docs: ## Builds the docs
	yarn vitepress build docs

.PHONY: build-blog
build-blog: ## Builds the blog
	cd blog && yarn && yarn build

.PHONY: dev
dev: ## Start docs dev server
	yarn vitepress dev docs

.PHONY: preview
preview: ## Preview the docs
	yarn vitepress preview docs

.PHONY: pull-melange-docs
pull-melange-docs: ## Pull melange docs
	if [ ! -d "melange" ]; then \
		opam source melange.$$(opam show melange -f version --color never) --dir melange; \
	fi
	ODOC_SYNTAX=$(SYNTAX) $(DUNE) build @doc-markdown
	rm -rf docs/api/$(SYNTAX)
	mkdir -p docs/api/$(SYNTAX)
	cp -r _build/default/_doc/_markdown/melange docs/api/$(SYNTAX)/
	# Keep only Belt*, Dom*, Node* files and Js* (but exclude Js_parser)
	# Exclude Js_Nullable until https://github.com/melange-re/melange/pull/1619
	cd docs/api/$(SYNTAX)/melange && find . -type f -name "Js_Nullable*.md" -delete
	cd docs/api/$(SYNTAX)/melange && find . -type f -name "Js_parser*.md" -delete
	cd docs/api/$(SYNTAX)/melange && find . -type f -name "*.md" ! -name "Js*.md" ! -name "Belt*.md" ! -name "Dom*.md" ! -name "Node*.md" ! -name "index.md" -delete
