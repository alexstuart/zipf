.PHONY : all clean help settings results

COUNT=bin/countwords.py
COLLATE=bin/collate.py
PLOT=bin/plotcounts.py
PLOTPARAMS=bin/plotparams.yml
SUMMARY=bin/book_summary.sh
DATA=$(wildcard data/*.txt)
RESULTS=$(patsubst data/%.txt,results/%.csv,$(DATA))

## all : Regenerate all results.
all : results/collated.png

## results : creates or updates any result files that are missing or out of date
results : $(RESULTS)

## results/collated.png: plot the collated results.
results/collated.png : results/collated.csv $(PLOTPARAMS)
	python $(PLOT) --plotparams $(word 2,$^)  $< --outfile $@

## results/collated.csv : collate all results.
results/collated.csv : $(RESULTS) $(COLLATE)
	@mkdir -p results
	python $(COLLATE) $(RESULTS) > $@

## results/%.csv: Regenerate result for any book
results/%.csv : data/%.txt $(COUNT) $(SUMMARY)
	@bash $(SUMMARY) $< Title:
	@bash $(SUMMARY) $< Author:
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
	@echo PLOT: $(PLOT)

## help : show this message
help :
	@grep '^##' ./Makefile
