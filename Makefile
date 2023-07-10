project_name = documentation-site

DUNE = opam exec -- dune

.DEFAULT_GOAL := help

.PHONY: help
help: ## Print this help message
	@echo "List of available make commands";
	@echo "";
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "  \033[36m%-15s\033[0m %s\n", $$1, $$2}';
	@echo "";

.PHONY: create-switch
create-switch: ## Create opam switch
	opam switch create . 4.14.1 -y --deps-only

.PHONY: init
init: create-switch install ## Configure everything to develop this repository in local

.PHONY: install
install: ## Install development dependencies
	opam update
	opam install -y . --deps-only
	opam pin -y add $(project_name).dev .

.PHONY: check-reason
check-reason: ## Checks that Reason syntax snippets are well formed
	$(DUNE) build @re

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
build-playground: install ## Builds the playground
	$(DUNE) build @playground-assets
	cd playground && yarn && yarn build
