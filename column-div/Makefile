# Name of the filter file, *with* `.lua` file extension.
FILTER_FILE := $(wildcard *.lua)
# Name of the filter, *without* `.lua` file extension
FILTER_NAME = $(patsubst %.lua,%,$(FILTER_FILE))

# Allow to use a different pandoc binary, e.g. when testing.
PANDOC ?= pandoc
# Allow to adjust the diff command if necessary
DIFF = diff

# Test that running the filter on the sample input document yields
# the expected output.
#
test: test_latex test_html
# The automatic variable `$<` refers to the first dependency
# (i.e., the filter file).
test_html: $(FILTER_FILE) test/input.md
	$(PANDOC) --lua-filter=$< --to=html --standalone test/input.md | \
		$(DIFF) test/expected.html -

test_latex: $(FILTER_FILE) test/input.md
	$(PANDOC) --lua-filter=$< --to=latex --standalone test/input.md | \
		$(DIFF) test/expected.tex -

# Ensure that the `test` target is run each time it's called.
.PHONY: test

# Re-generate the expected output. This file **must not** be a
# dependency of the `test` target, as that would cause it to be
# regenerated on each run, making the test pointless.
expected: test/expected.html test/expected.tex

test/expected.html: $(FILTER_FILE) test/input.md
	$(PANDOC) --lua-filter=$< --standalone --to=html --output=$@ \
		test/input.md

test/expected.tex: $(FILTER_FILE) test/input.md
	$(PANDOC) --lua-filter=$< --standalone --to=latex --output=$@ \
		test/input.md

test/expected.ast: $(FILTER_FILE) test/input.md
	$(PANDOC) --lua-filter=$< --standalone --to=native --output=$@ \
		test/input.md

