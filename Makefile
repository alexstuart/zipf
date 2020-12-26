.PHONY : all clean

COUNT=bin/countwords.py
RUN_COUNT=python $(COUNT)

# Regenerate all results.
all : results/moby_dick.csv results/jane_eyre.csv \
	results/time_machine.csv

# Remove all generated files.
clean :
	rm -f results/*.csv

# Regenerate results for any book
results/%.csv : data/%.txt $(COUNT)
	$(RUN_COUNT) $< > $@