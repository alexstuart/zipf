.PHONY : all clean settings

COUNT=bin/countwords.py
DATA=$(wildcard data/*.txt)
RESULTS=$(patsubst data/%.txt,results/%.csv,$(DATA))

# Regenerate all results.
all : $(RESULTS)

# Remove all generated files.
clean :
	rm -f results/*.csv

# Regenerate results for any book
results/%.csv : data/%.txt $(COUNT)
	python $(COUNT) $< > $@

settings :
	@echo COUNT: $(COUNT)
	@echo DATA: $(DATA)
	@echo RESULTS: $(RESULTS)
