LATEX=latexmk
SOURCE:=$(wildcard *.tex)

DFFLAG=-xelatex -interaction=nonstopmode
RFLAG=-quiet
DFLAG=-pv

debug:
	$(LATEX) $(DFFLAG) $(DFLAG) $(SOURCE)
release:
	$(LATEX) $(DFFLAG) $(RFLAG) $(SOURCE)
	$(LATEX) -c
clean:
	$(LATEX) -C
