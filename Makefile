SCRIPTS := $(wildcard scripts/*.sh tests/*.sh site/scripts/*.sh)

.PHONY: check lint test

check: lint test

lint:
	@for f in $(SCRIPTS); do bash -n "$$f" || exit 1; done
	@if command -v shellcheck >/dev/null; then shellcheck $(SCRIPTS); \
	else echo "shellcheck not installed; skipped"; fi

test:
	python3 -m unittest discover tests
	bash tests/weekly_test.sh
