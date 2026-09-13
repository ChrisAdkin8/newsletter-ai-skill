SCRIPTS := $(wildcard scripts/*.sh tests/*.sh site/scripts/*.sh)

.PHONY: check lint test

check: lint test

lint:
	@for f in $(SCRIPTS); do bash -n "$$f" || exit 1; done
	@if command -v shellcheck >/dev/null; then shellcheck $(SCRIPTS); \
	else echo "shellcheck not installed; skipped"; fi
	@for env in '' '<key>PROBE</key><string>1</string>'; do \
	  sed -e "s|@HOME@|$$HOME|g" -e "s|@REPO@|$$PWD|g" -e "s|@EXTRA_ENV@|$$env|" \
	    scripts/local.newsletter-ai.weekly.plist.in | plutil -lint -s - || exit 1; \
	done

test:
	python3 -m unittest discover tests
	bash tests/weekly_test.sh
