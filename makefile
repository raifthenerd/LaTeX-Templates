OUTDIR=output

LATEX=latexmk -outdir=$(OUTDIR)

DFFLAG=-xelatex -interaction=nonstopmode
RFLAG=-quiet
DFLAG=-pv

debug:
	$(LATEX) $(DFFLAG) $(DFLAG)
release:
	$(LATEX) $(DFFLAG) $(RFLAG)
	$(LATEX) -c
clean:
	$(LATEX) -C
