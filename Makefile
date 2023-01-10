.PHONY: help
help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'
.DEFAULT_GOAL := help

.PHONY: install-deps
install-deps: ## install dependencies

.PHONY: format
format: ## format codes
	cargo fmt --all

.PHONY: format-check
format-check: ## check format
	cargo fmt --all --check

.PHONY: lint
lint: ## lint codes
	cargo fmt --all -- --check --verbose
	cargo clippy -- -D warnings --verbose

.PHONY: build
build: ## build an app
	cargo build --verbose

.PHONY: test
test: ## run tests
	cargo test --release --all-features --verbose

.PHONY: docs
docs: ## generate docs
	cargo doc

.PHONY: run
run: ## run an app
	cargo run --verbose -- --name ks6088ts --count 3

.PHONY: ci-test
ci-test: install-deps format-check lint build test docs run ## ci test
