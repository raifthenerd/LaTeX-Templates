LATEX=latexmk
TARGET=main.pdf

DFFLAG=-xelatex -interaction=nonstopmode
RFLAG=-quiet
DFLAG=-pv

debug:
	$(LATEX) $(DFFLAG) $(DFLAG) $(TARGET:.pdf=.tex)
release:
	$(LATEX) $(DFFLAG) $(RFLAG) $(TARGET:.pdf=.tex)
	$(LATEX) -c
clean:
	$(LATEX) -C
