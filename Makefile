.PHONY : all clean settings help

COUNT=bin/countwords.py
DATA=$(wildcard data/*.txt)
RESULTS=$(patsubst data/%.txt,results/%.csv,$(DATA))
COLLATE=bin/collate.py
PLOT=bin/plotcounts.py

## all : Regenerate all results.
all : results/collated.png

## results/collated.png: plot the collated results.
results/collated.png : results/collated.csv
	python $(PLOT) $< --outfile $@

## results/collated.csv : collate all results.
results/collated.csv : $(RESULTS) $(COLLATE)
	mkdir -p results
	python $(COLLATE) $(RESULTS) > $@

## results/%.csv: Regenerate results for any book
results/%.csv : data/%.txt $(COUNT)
	python $(COUNT) $< > $@

## clean :  Remove all generated files.
clean :
	rm -f $(RESULTS) results/collated.csv results/collated.png

## settings : show variables' values
settings :
	@echo COUNT: $(COUNT)
	@echo DATA: $(DATA)
	@echo RESULTS: $(RESULTS)
	@echo COLLATE: $(COLLATE)

## help : show this message
help :
	@grep '^##' ./Makefile
