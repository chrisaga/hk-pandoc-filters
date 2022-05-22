# List of the filter directories
FILTERS = column-div tables-rules

# Rule to make targets in each filter directories
expected docs:
	$(foreach subdir,$(FILTERS),$(MAKE) -C $(subdir) $@;)

# For some reason Github CI needs this rule to perform tests
# this sould be equivalent
test:
	$(foreach subdir,$(FILTERS),cd $(subdir) && $(MAKE) $@;cd ..;)

# Ensure that the `test` target is run each time it's called.
.PHONY: test
