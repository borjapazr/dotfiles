# Thin wrapper over `dot self *`, for muscle memory and for CI to have one
# obvious entrypoint per gate.

.DEFAULT_GOAL := help
DOT := ./bin/dot

.PHONY: help check lint fmt format test install update hooks

help: ## Show this help
	@printf '\n\033[1m.dotfiles\033[0m — make targets\n\n'
	@grep -hE '^[a-z][a-z-]*:.*?## ' $(MAKEFILE_LIST) \
		| awk 'BEGIN{FS=":.*?## "}{printf "  \033[36m%-9s\033[0m %s\n", $$1, $$2}'
	@printf '\nEvery target is a thin wrapper over `dot self <name>`.\n\n'

check: lint fmt test ## Run every gate CI runs

lint: ## Static analysis with shellcheck
	@$(DOT) self lint

fmt: ## Report formatting drift with shfmt
	@$(DOT) self format --check

format: ## Rewrite files to the canonical format
	@$(DOT) self format

test: ## Run the bats test suite
	@$(DOT) self test

install: ## Install the dotfiles on this machine
	@$(DOT) self install

update: ## Update the dotfiles and their modules
	@$(DOT) self update

hooks: ## Route git at the repo's tracked hooks
	@git config core.hooksPath .githooks
	@echo "git hooks enabled from .githooks/"
