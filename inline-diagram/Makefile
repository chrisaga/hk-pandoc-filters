# Name of the filter file, *with* `.lua` file extension.
WRITER_FILE := $(wildcard *.lua)
# Name of the filter, *without* `.lua` file extension
WRITER_NAME = $(patsubst %.lua,%,$(FILTER_FILE))

# Allow to use a different pandoc binary, e.g. when testing.
PANDOC ?= pandoc
# Allow to adjust the diff command if necessary
DIFF = diff

# Test that running the filter on the sample input document yields
# the expected output.
#
test: test1
# The automatic variable `$<` refers to the first dependency
# (i.e., the filter file).
test1: $(WRITER_FILE) test/input.md
	$(PANDOC) --write=$< --template=default.latex test/input.md | \
		$(DIFF) test/expected.tex -

# Ensure that the `test` target is run each time it's called.
.PHONY: test

# Re-generate the expected output. This file **must not** be a
# dependency of the `test` target, as that would cause it to be
# regenerated on each run, making the test pointless.
expected: test/expected.tex 

test/expected.tex: $(WRITER_FILE) test/input.md
	$(PANDOC) --write=$< --template=default.latex --output=$@ \
		test/input.md

