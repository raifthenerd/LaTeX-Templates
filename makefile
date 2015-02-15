LATEX=latexmk

DFFLAG=-xelatex -interaction=nonstopmode -outdir=output
RFLAG=-quiet
DFLAG=-pv

debug:
	$(LATEX) $(DFFLAG) $(DFLAG)
release:
	$(LATEX) $(DFFLAG) $(RFLAG)
	$(LATEX) -c
clean:
	$(LATEX) -C
