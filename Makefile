# List of the filter directories
FILTERS = column-div tables-rules

# Rule to make targets in each filter directories
test expected docs:
	$(foreach subdir,$(FILTERS),$(MAKE) -C $(subdir) $@;)

# Ensure that the `test` target is run each time it's called.
.PHONY: test
